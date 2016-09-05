var API = 'http://172.16.0.2:8888';

var devstatApp = angular.module('devstatApp', []);

devstatApp.component('repoList', {
    templateUrl: 'templates/repo-list.html',
    controller: function RepoListController($http) {
        var self = this;

        $http.get(API + '/TheKevJames').then(
            function(response) {
                self.repos = response.data['repos'];

                for (var i = 0; i < self.repos.length; i++) {
                    (function(j) {
                        $http.get(API + '/TheKevJames/' + self.repos[j].name).then(
                            function(response) {
                                self.repos[j] = response.data['repo'];
                            },
                            function(err) { console.log(err); })})(i);
                }
            });
    }
});
