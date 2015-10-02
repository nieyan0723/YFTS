angular.module('ui.bootstrap.demo', [ 'ngAnimate', 'ui.bootstrap', 'ngResource']);
var app = angular.module('ui.bootstrap.demo');
app.config(['$httpProvider', function ($httpProvider) {    
	$httpProvider.defaults.headers.post['Content-Type'] = 'application/json; charset=UTF-8';
}]);
app.service("shared", function() {
	var _stock = null;
	var _user = null;
	return {
		getStock : function() {
			return _stock;
		},
		setStock : function(stock) {
			_stock = stock;
		},
		getUser : function() {
			return _user;
		},
		setUser : function(user){
			_user = user;
		}
	};
});
app.controller("mainController", ["$scope", "$interval", "$http", "$rootScope", "shared", 
                                  function($scope, $interval, $http, $rootScope, shared) {
	$scope.user;
	$http({
		method : "GET",
		url : "validTran",
	}).success(function(data, update) {
		$scope.user = data;
		shared.setUser($scope.user);
		console.log(shared.getUser());
	}).error(function(data) {
		console.log("AJAX ERROR");
	});	
	
	$scope.stocksArray = [];
	$interval(function() {
		$http({
			method : "GET",
			url : "market",
		}).success(function(data) {
			$scope.stocksArray = data;
		}).error(function(data) {
			console.log("AJAX ERROR!");
		});
	}, 2000);
	$scope.pass = function(stock) {
		shared.setStock(stock);
	};
	
//	$scope.hasStock = function(stock) {
//		$scope.
//	}
}]);
app.controller('ModalDemoCtrl', ['$scope', '$modal', '$log', 'shared', 
                                 function ($scope, $modal, $log, shared) {
	$scope.item;
	$scope.animationsEnabled = true;
	
	$scope.open = function () {
		
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

app.controller('ModalInstanceCtrl', function ($scope, $modalInstance, $http, items, shared) {
	$scope.user = shared.getUser();	
	$scope.Math = window.Math;
	$scope.buyItem = items;
	$scope.upper = Math.floor($scope.user.balance / $scope.buyItem.price);
	$scope.quan = 1;
	$scope.newTran;
	$scope.$watch("quan",function(val,old){
	       $scope.quan = parseInt(val); 
	});
		
	$scope.send = function(){
		$http({
			method: "POST",
			url: "addPending",
			data: $scope.newTran = {
					tid:0,
					own: {
						user: $scope.user,
						stock: {
							sid: $scope.buyItem.sid,
							symbol: $scope.buyItem.symbol,
							stockName: $scope.buyItem.stockName
						},
					},
					amount: $scope.quan,
					price: $scope.buyItem.price,
					ts: new Date()
			}
		}).success(function (response) {
			console.log(response);
		}).error(function (data) {
			console.log(data);
		}); 
	};
	
	$scope.ok = function () {
		$scope.send();
		$modalInstance.close($scope.buyItem);
	};

	$scope.cancel = function () {
		$modalInstance.dismiss('cancel');
	};
});