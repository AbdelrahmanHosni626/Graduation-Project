<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RegisterController extends Controller
{
    public function register(Request $request)
    {

        $v = Validator::make($request->all(), [
            'name' => 'required|max:255',
            'email' => 'required|email|unique:users|max:255',
            'phone' => 'required|unique:users',
            'password' => ['required', 'min:8']
        ]);

        if ($v->fails()) {
            return response()->json(['validation_error' => $v->errors()->all()]);
        }

        $img = $request->image;
        if ($request->hasFile('image')) {
            $fileName = '/users/apis/' . time() . $img->getClientOriginalName();
            $img->move(public_path('../storage/app/public/users/apis/'), $fileName);
            // $fileName=url('/public/storage/').$fileName;

        } else {
            $fileName = "";
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'phone' => $request->phone,
             'ssn'=>$request->ssn,
            'avatar' => $fileName,
            'email_verified_at' => now(),
            // 'provider' => $request->provider ? $request->provider : "",
            // 'provider_id' => $request->provider_id ? $request->provider_id : "",
            // "phone_verified" => 0,
            'login' => 1,
            'type' => 0,
        ]);

        //$address =$user->address->getcoordinates();

        // $request['remember_token'] = Str::random(10);
        $token = $user->createToken('Laravel Password Grant Client')->accessToken;

        return response()->json([
            'message'=>"user signed up successfully",
            'status'=>true,
            'data' =>new UserResource(User::find($user->id)),
            'token'  => $token,
        ]);
    }

    public function driver_register(Request $request)
    {

        $v = Validator::make($request->all(), [
            'name' => 'required|max:255',
            'email' => 'required|email|unique:users|max:255',
            'phone' => 'required|unique:users',
            'password' => ['required', 'min:8'],
            'image' => ['required']
        ]);

        if ($v->fails()) {
            return response()->json(['validation_error' => $v->errors()->all()]);
        }

        $img = $request->image;
        if ($request->hasFile('image')) {
            $fileName = '/users/apis/' . time() . $img->getClientOriginalName();
            $img->move(public_path('../storage/app/public/users/apis/'), $fileName);
            // $fileName=url('/public/storage/').$fileName;

        } else {
            $fileName = "";
        }

        // $lat = (float) $request['lat'];
        // $lng = (float) $request['lng'];


        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'phone' => $request->phone,
            'avatar' => $fileName,
            'ssn'=>$request->ssn,
            'email_verified_at' => now(),
            // 'provider' => $request->provider ? $request->provider : "",
            // 'provider_id' => $request->provider_id ? $request->provider_id : "",
            // "phone_verified" => 0,
            'login' => 1,
            'type' => 1,
        ]);

        //$address =$user->address->getcoordinates();

        // $request['remember_token'] = Str::random(10);
        $token = $user->createToken('Laravel Password Grant Client')->accessToken;

        return response()->json([
            'message'=>"user signed up successfully",
            'status'=>true,
            'data' =>new UserResource(User::find($user->id)),
            'token'  => $token,
        ]);
    }
    public function logout(Request $request)
    {
        $user = User::where('id', auth('api')->id())->first();
dd($user);
        $accessToken = $user->token();
        dd($accessToken);


        DB::table('oauth_refresh_tokens')
            ->where('access_token_id', $accessToken->id)
            ->update([
                'revoked' => true
            ]);
        $user->update([
            'login' => 0
        ]);
        $accessToken->revoke();
        return response()->json([
            'message' => 'Successfully logged out',
            'status'=>true,
        ]);
    }


    public function login(Request $request)
    {
        
        $loginData = $request->validate([
            'email' => 'required',
            //'phone' => 'required',
            'password' => 'required'
        ]);
        if (!auth()->attempt($loginData)) {
            return response(['message' => 'Invalid Credentials phone Or Password']);
        }
        
            $accessToken = auth()->user()->createToken('authToken')->accessToken;
            $user = User::where('id', auth()->user()->id)->first();
            
            $user->update([
                'login' => 1
            ]);
            return response([
                'message'=>"user signed in successfully",
                'status'=>true,
                'data' =>new UserResource(User::find($user->id)),
                'token' => $accessToken
            ]);
        
    }


    public function profile()
    {
        
        $user=User::where('id',auth('api')->id())->first();
        
        return response([
                'message'=>"user signed in successfully",
                'status'=>true,
                'data' =>new UserResource($user)
            
            ]);
    }
}
