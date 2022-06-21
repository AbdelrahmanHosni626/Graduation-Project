<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\OrderController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});



Route::post('/register', [RegisterController::class, 'register']);
Route::post('/driver-register', [RegisterController::class, 'driver_register']);

Route::post('/login', [RegisterController::class, 'login']);
Route::post('/logout', [RegisterController::class, 'logout']);

Route::middleware('auth:api')->group(function(){
Route::post('/store-order', [OrderController::class, 'store_order']);
Route::get('/user-orders', [OrderController::class, 'orders']);
Route::get('/driver-orders', [OrderController::class, 'driver_orders']);
Route::get('/single-order/{id}', [OrderController::class, 'order']);
Route::get('/last-user-order', [OrderController::class, 'last_user_order']);
Route::get('/last-driver-order', [OrderController::class, 'last_driver_order']);

});

Route::get('/orders',function () {
    return "welcome";
});

Route::get('/profile', [RegisterController::class, 'profile']);