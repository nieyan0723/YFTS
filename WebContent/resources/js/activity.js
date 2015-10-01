angular.module('ui.bootstrap.demo', [ 'ngAnimate', 'ui.bootstrap' ]);
var app = angular.module('ui.bootstrap.demo');
app.service("shared", function() {
	var _stock = null;
	return {
		getStock : function() {
			return _stock;
		},
		setStock : function(stock) {
			_stock = stock;
		}
	};
});
app.controller("mainController", ["$scope", "$interval", "$http", "$rootScope", "shared", 
                                  function($scope, $interval, $http, $rootScope, shared) {
	$scope.stocksArray = [];
	// $interval(function() {
	$http({
		method : "GET",
		url : "market",
	}).success(function(data) {
		$scope.stocksArray = data;
	}).error(function(data) {
		alert("AJAX ERROR!");
	});
	// }, 5000);
	$scope.pass = function(stock) {
		shared.setStock(stock);
	};
}]);
app.controller('ModalDemoCtrl', ['$scope', '$modal', '$log', '$rootScope', 'shared', 
                                 function ($scope, $modal, $log, $rootScope, shared) {
	$scope.item;

	$scope.animationsEnabled = true;

	$scope.open = function () {
		console.log(shared.getStock());
		$scope.item = shared.getStock();
    var modalInstance = $modal.open({
      animation: $scope.animationsEnabled,
      templateUrl: 'myModalContent.html',
      controller: 'ModalInstanceCtrl',
      resolve: {
        items: function () {
          return $scope.item;
        }
      }
    });

    modalInstance.result.then(function (selectedItem) {
      $scope.selected = selectedItem;
    }, function () {
      $log.info('Modal dismissed at: ' + new Date());
    });
  };

  $scope.toggleAnimation = function () {
    $scope.animationsEnabled = !$scope.animationsEnabled;
  };

}]);

// Please note that $modalInstance represents a modal window (instance) dependency.
// It is not the same as the $modal service used above.

app.controller('ModalInstanceCtrl', function ($scope, $modalInstance, $http, items) {

  $scope.buyItem = items;
  $scope.user;
	$http({
		method : "GET",
		url : "validTran",
	}).success(function(data) {
		$scope.user = data;
		console.log($scope.user);
	}).error(function(data) {
		alert("AJAX ERROR!");
	});
  $scope.ok = function () {
    $modalInstance.close($scope.buyItem);
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
});