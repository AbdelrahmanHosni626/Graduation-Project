<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

use Tcg\Voyager\Models\User;

class Order extends Model
{
    protected $fillable=['id','car_num','latituide','longtuide','litres','price','details','status','user_id','driver_id','gas_type'];

    public function user(){
        return $this->belongsTo(User::class,'user_id');
    }
    
        public function driver(){
        return $this->belongsTo(User::class,'driver_id');
    }
    
}
