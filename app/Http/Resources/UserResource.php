<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Storage;
class UserResource extends JsonResource
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
            'id'=>$this->id,
            'name'=>$this->name?$this->name:"",
            'email'=>$this->email?$this->email:"",
            'phone'=>$this->phone??"",
            'image'=>Storage::Disk('public')->url($this->avatar)??"",
            'login'=>$this->login??"",
            'type'=>$this->type??"",
            'ssn'=>$this->ssn??"",

        ];
    }
}
