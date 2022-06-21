<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use App\Order;

class OrderSentMail extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */

    protected $order;
    public function __construct(Order $order)
    {
        $this->order  = $order;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
       return $this->view('mail.orders')
        ->with([
            'car_num'=> $this->order->car_num ,
            'litres'=> $this->order->litres ,
            'details'=> $this->order->details ,
            'price'=> $this->order->price ,
            'gas_type'=> $this->order->gas_type,
        ]);
    }
}
