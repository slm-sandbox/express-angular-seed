@SubView = ["$scope","api","$location",($scope,api,$location)->
  api.get (items)->
    console.log items
    api.post {data:"this is data"}, ()->
      console.log "posted some data"

  $scope.activeLocation = $location.path()
]


