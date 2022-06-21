<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id'   => $this->id,
        'car_num'   => $this->car_num??'',
        'gas_type'    =>$this->gas_type??'',
        'latituide' => $this->latituide??'',
        'longtuide' => $this->longtuide??'',
        'litres'    => $this->litres??'',
        'price'     =>$this->price??'',
        'details'   =>$this->details??'',
        'user' =>$this->user?new UserResource($this->user):"",
        'user_id'   =>$this->user_id??"",
         
         'driver' =>$this->driver?new UserResource($this->driver):"",
         'driver_id' =>$this->driver_id??"",
        'status'    =>$this->status??"",

    ];
    }
}
