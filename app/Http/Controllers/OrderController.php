<?php

namespace App\Http\Controllers;
use App\Http\Resources\OrderResource;
use App\Order;
use Illuminate\Support\Facades\Validator;
use App\Mail\OrderSentMail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class OrderController extends Controller
{
    public function store_order(Request $request){
        $v = Validator::make($request->all(), [
            'car_num' => 'required|max:255',
            'latituide' => 'required|max:255',
            'longtuide' => 'required|max:255',
            'litres' => 'required',
            'price'=>'required',
            'gas_type'=>'required',
        ]);

        if ($v->fails()) {
            return response()->json(['validation_error' => $v->errors()->all()]);
        }
        $order = Order::create([
            'car_num' => $request->car_num,
            'latituide' => $request->latituide,
            'longtuide' => $request->longtuide,
            'litres' => $request->litres,
            'price' =>  $request->price,
            'details'=>$request->details,
            'user_id'=>auth()->id(),
            'driver_id'=>$request->driver_id,
            'status'=>0,
            'gas_type'=>$request->gas_type,
        ]);

        Mail::to(auth()->user()->email)->send(new OrderSentMail($order));

            return response()->json([
              'message' => 'Data Returned Successfully',
            'status' => true,
            'data' =>new OrderResource(Order::find($order->id))
            ]);


    }

    public function orders(){
        $orders=Order::where('user_id',auth()->id())->get();

            return response()->json([
              'message' => 'Data Returned Successfully',
            'status' => true,
            'data' => OrderResource::collection($orders)
            ]);

    }

    public function last_user_order(){
        $orders=Order::where('user_id',auth()->id())->where('status',0)->orderBy('created_at','desc')->first();

        if($orders){
            return response()->json([
              'message' => 'Data Returned Successfully',
            'status' => true,
            'data' => OrderResource::make($orders)
            ]);
    }else{
            return response()->json([
              'message' => 'No Data Returned',
            'status' => true,
            'data' => ""
            ]);
        }

    }

    public function driver_orders(){
        $orders=Order::where('driver_id',auth()->id())->get();

            return response()->json([
              'message' => 'Data Returned Successfully',
            'status' => true,
            'data' => OrderResource::collection($orders)
            ]);

    }

    public function last_driver_order(){
        $orders=Order::
            where('driver_id',auth()->id())->where('status',0)->orderBy('created_at','desc')->first();

        if($orders){
            return response()->json([
              'message' => 'Data Returned Successfully',
            'status' => true,
            'data' => OrderResource::make($orders)
            ]);
        }else{
            return response()->json([
              'message' => 'No Data Returned',
            'status' => true,
            'data' => ""
            ]);
        }

    }

    public function order($id){

        $order=Order::where('id',$id)->first();

           return response()->json([
              'message' => 'Data Returned Successfully',
            'status' => true,
            'data' =>new OrderResource($order)
            ]);

    }
}
