<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Support\Facades\Request;

class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    protected function redirectTo($request)
    {
        if(Request::segment(1) == "api"){
            throw new HttpResponseException(response()->json(
                [
                    'success' => false,
                    'message'   => 'Not Authenticated'
                ], 401));  
   
        }  

        if (! $request->expectsJson()) {
            return route('login');
        }
    }
}
