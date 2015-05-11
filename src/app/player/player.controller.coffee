angular.module "jkbx"
  .controller "PlayerCtrl", ($scope, $stateParams, $firebaseArray, $timeout) ->
    ref = new Firebase("https://jkbx.firebaseio.com/party/#{$stateParams.name}/tracks")

    $scope.tracks = $firebaseArray(ref)
    $scope.playerHeight = window.innerHeight
    $scope.playerWidth = window.innerWidth
    $scope.index = 0

    $scope.tracks.$loaded().then (_tracks) ->
      $scope.playing = $scope.tracks[0]

    $scope.$on 'youtube.player.ready', ($event, player) ->
      $scope.playing.playing = true
      $scope.tracks.$save($scope.playing)
      player.playVideo()

    $scope.$on 'youtube.player.ended', ($event, player) ->
      $scope.playing.playing = false
      $scope.tracks.$save($scope.playing)
      $scope.index += 1
      $scope.playing = $scope.tracks[$scope.index]

