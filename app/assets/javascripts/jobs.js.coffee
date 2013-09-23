jobs = angular.module('jobs', ['ngResource'])

###
jobs.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/', controller: 'RootCtrl', templateUrl: 'templates')
]
###

jobs.factory('resourceCache', ['$cacheFactory', ($cacheFactory) ->
  $cacheFactory('resourceCache')
])

jobs.directive('preloadResource', ['resourceCache', (resourceCache) ->
  link: (scope, element, attrs) ->
    resourceCache.put(attrs.preloadResource, element.html())
])

### angular 1.2
jobs.factory('Jobs', ['$resource', 'resourceCache', ($resource, resourceCache) ->
  $resource('/jobs', {}, query: { method: 'GET', url: '/jobs', isArray: true, cache: resourceCache })
])
###

jobs.controller('JobsCtrl', ['$scope', 'resourceCache', ($scope, resourceCache) ->
  grouping = {}
  angular.forEach angular.fromJson(resourceCache.get('/jobs')), (job) ->
    job.created_at = new Date(job.created_at)
    group = (grouping[job.job_type + job.destination] or= [])
    group.push(job)

  groups = ({ jobs: jobs } for k, jobs of grouping)
  for group in groups
    group.job_type = group.jobs[0].job_type
    group.created_at = (job.created_at for job in group.jobs).reduce (a, b) -> if a < b then a else b
    group.status = 'Mixed'
    group.destination = group.jobs[0].destination
    group.pick = group.jobs.reduce ((a, j) -> a + j.pick), 0
    group.school = group.jobs[0].school

  $scope.groups = groups

  $scope.orderPredicate = 'job_type'
  $scope.orderReverse = false

  $scope.orderBy = (column) ->
    if column == $scope.orderPredicate
      $scope.orderReverse = !$scope.orderReverse
    else
      $scope.orderReverse = false
      $scope.orderPredicate = column
])
