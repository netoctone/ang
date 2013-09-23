Array::uniq = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

jobs = angular.module('jobs', ['ngResource'])

jobs.filter('ago', ->
  (input) ->
    now = new Date()
    days = (now - input) / 86400000
    return "#{days - days % 1}d" if days > 1

    hours = days*24
    return "#{hours - hours % 1}h" if hours > 1

    minutes = hours*60
    "#{minutes - minutes % 1}m"
)

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

jobs.factory('CurFilter', ->
  {}
)

jobs.controller('JobsCtrl', ['$scope', 'resourceCache', 'CurFilter', ($scope, resourceCache, CurFilter) ->
  $scope.filterGroup = (group) ->
    return false if CurFilter.tags && group.tagsAll.indexOf(CurFilter.tags) == -1
    return false if CurFilter.status && group.statusAll.indexOf(CurFilter.status) == -1
    return false if CurFilter.job_type?.length > 0 && CurFilter.job_type.indexOf(group.job_type) == -1
    true

  $scope.filterJob = (job) ->
    return false if CurFilter.tags && CurFilter.tags != job.tags
    return false if CurFilter.status && CurFilter.status != job.status
    true

  grouping = {}
  angular.forEach angular.fromJson(resourceCache.get('/jobs')), (job) ->
    job.created_at = new Date(job.created_at)
    job.status_changed_at = new Date(job.status_changed_at)
    group = (grouping[job.job_type + job.destination] or= [])
    group.push(job)

  groups = ({ jobs: jobs } for k, jobs of grouping)
  for group in groups
    group.job_type = group.jobs[0].job_type
    group.created_at = (job.created_at for job in group.jobs).reduce (a, b) -> if a < b then a else b

    for mixField in ['status', 'trolley', 'tags']
      uniq = group.jobs.map((j) -> j[mixField]).uniq()
      group["#{mixField}All"] = uniq
      group[mixField] = if uniq.length == 1 then uniq[0] else 'Mixed'

    group.destination = group.jobs[0].destination
    group.pick = group.jobs.reduce ((a, j) -> a + j.pick), 0
    group.school = group.jobs.map((j) -> j.school).uniq().join('/')

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

jobs.factory('Filter', ['$resource', ($resource) ->
  $resource('/filters/:id', { id: '@id' })
])

jobs.controller('FilterCtrl', ['$scope', 'resourceCache', 'CurFilter', 'Filter', ($scope, resourceCache, CurFilter, Filter) ->
  $scope.curFilter = { job_types: {} }
  $scope.job_types = angular.fromJson resourceCache.get('/job_types')
  $scope.statuses = angular.fromJson resourceCache.get('/statuses')

  $scope.filters = angular.fromJson resourceCache.get('/filters')

  $scope.applyFilter = ->
    CurFilter.tags = switch $scope.curFilter.tags
      when null then null
      when true then 'Yes'
      when false then 'No'
    CurFilter.status = $scope.curFilter.status
    CurFilter.job_type = (type for type, selected of $scope.curFilter.job_types when selected)

  $scope.setFilter = (filter) ->
    $scope.filtersOpen = false
    $scope.curFilter = filter
    $scope.applyFilter()

  $scope.save = ->
    f = new Filter()
    angular.extend(f, $scope.curFilter)
    f.$save()
])
