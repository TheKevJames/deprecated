var API = location.hostname === '127.0.0.1' ? 'http://127.0.0.1:8081' : 'https://api.devstat.thekev.in';

var devstatApp = angular.module('devstatApp', []);

devstatApp.component('appList', {
    controller: function AppListController($http) {
        $http.get('/test.yml').then(
            (resp) => {
                let config = jsyaml.safeLoad(resp.data);
                this.apps = config.apps;
            },
            (err) => console.log(err)
        );
    },
    templateUrl: 'templates/app-list.html'
});

devstatApp.directive('appItem', function() {
    return {
        controller: function AppItemController($http, $scope) {
            if ($scope.app.repo) {
                $http.get(`${API}/github/${$scope.app.repo}`).then(
                    (resp) => $scope.repo = resp.data.repo,
                    (err) => console.log(err)
                );

                $scope.test = [];
                // TODO: consistent ordering
                if ($scope.app.test && $scope.app.test.indexOf('circleci') > -1) {
                    $http.get(`${API}/circleci/${$scope.app.repo}`).then(
                        (resp) => $scope.test.push(resp.data),
                        (err) => console.log(err)
                    );
                }
                if ($scope.app.test && $scope.app.test.indexOf('coveralls') > -1) {
                    $http.get(`${API}/coveralls/${$scope.app.repo}`).then(
                        (resp) => $scope.test.push(resp.data),
                        (err) => console.log(err)
                    );
                }
                if ($scope.app.test && $scope.app.test.indexOf('travis') > -1) {
                    $http.get(`${API}/travis/${$scope.app.repo}`).then(
                        (resp) => $scope.test.push(resp.data),
                        (err) => console.log(err)
                    );
                }

            }

            $scope.deploy = [];
            // TODO: consistent ordering
            if ($scope.app.deploy && $scope.app.deploy.dockerhub) {
                for (var idx in $scope.app.deploy.dockerhub) {
                    $http.get(`${API}/dockerhub/pulls/${$scope.app.deploy.dockerhub[idx]}`).then(
                        (resp) => $scope.deploy.push(resp.data),
                        (err) => console.log(err)
                    );
                    $http.get(`${API}/dockerhub/stars/${$scope.app.deploy.dockerhub[idx]}`).then(
                        (resp) => $scope.deploy.push(resp.data),
                        (err) => console.log(err)
                    );
                }
            }
            if ($scope.app.deploy && $scope.app.deploy.puppetforge) {
                for (var idx in $scope.app.deploy.puppetforge) {
                    $http.get(`${API}/puppetforge/downloads/${$scope.app.deploy.puppetforge[idx]}`).then(
                        (resp) => $scope.deploy.push(resp.data),
                        (err) => console.log(err)
                    );
                    $http.get(`${API}/puppetforge/score/${$scope.app.deploy.puppetforge[idx]}`).then(
                        (resp) => $scope.deploy.push(resp.data),
                        (err) => console.log(err)
                    );
                    $http.get(`${API}/puppetforge/version/${$scope.app.deploy.puppetforge[idx]}`).then(
                        (resp) => $scope.deploy.push(resp.data),
                        (err) => console.log(err)
                    );
                }
            }
            if ($scope.app.deploy && $scope.app.deploy.pypi) {
                for (var idx in $scope.app.deploy.pypi) {
                    $http.get(`${API}/pypi/${$scope.app.deploy.pypi[idx]}`).then(
                        (resp) => $scope.deploy.push(resp.data),
                        (err) => console.log(err)
                    );
                }
            }
            if ($scope.app.deploy && $scope.app.deploy.url) {
                for (var idx in $scope.app.deploy.url) {
                    $http.get(`${API}/url/${$scope.app.deploy.url[idx]}`).then(
                        (resp) => $scope.deploy.push(resp.data),
                        (err) => console.log(err)
                    );
                }
            }

            $scope.monitor = [];
            // TODO: sentry
            if ($scope.app.monitor && $scope.app.monitor.uptimerobot) {
                for (var idx in $scope.app.monitor.uptimerobot) {
                    $http.get(`${API}/uptimerobot/${$scope.app.monitor.uptimerobot[idx]}`).then(
                        (resp) => $scope.monitor.push(resp.data),
                        (err) => console.log(err)
                    );
                }
            }
        },
        scope: { app: '=' },
        templateUrl: 'templates/app-item.html'
    }
});
