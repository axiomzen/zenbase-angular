angular.module 'app', ['ui.router']
  .config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: '/views/main.html'
      .state 'partial',
        url: '/partial'
        templateUrl: '/views/partial.html'
