var API = 'API_URL';

var devstatApp = angular.module('devstatApp', []);

devstatApp.component('repoList', {
    controller: function RepoListController($http) {
        this.user = 'TheKevJames';

        var self = this;
        $http.get(API + '/' + self.user).then(
            function(resp) { self.repos = resp.data['repos'] },
            function(err) { console.log(err) });
    },
    templateUrl: 'templates/repo-list.html'
});

devstatApp.directive('repoItem', function() {
    return {
        controller: function RepoItemController($http, $scope) {
            $http.get(API + '/' + $scope.user + '/' + $scope.repo.name).then(
                function(resp) { $scope.repo = resp.data['repo'] },
                function(err) { console.log(err) });
        },
        scope: { repo: '=', user: '=' },
        templateUrl: 'templates/repo-item.html'
    }
});
