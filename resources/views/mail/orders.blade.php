<style>

    @media only screen and (max-width : 640px) {

        table[class="container"] {
            width: 98% !important;
        }
        td[class="bodyCopy"] p {
            padding: 0 15px !important;
            text-align: left !important;
        }
        td[class="spacer"] {
            width: 15px !important;
        }
        td[class="belowFeature"] {
            width: 95% !important;
            display: inline-block;
            padding-left: 15px;
            margin-bottom: 20px;
        }
        td[class="belowFeature"] img {
            float: left;
            margin-right: 15px;
        }

        table[class="belowConsoles"] {
            width: 100% !important;
            display: inline-block;
        }

        table[class="belowConsoles"] img {
            margin-right: 15px;
            margin-bottom: 15px;
            float: left;
        }


    }

    @media only screen and (min-width: 481px) and (max-width: 560px) {

        td[class="Logo"] {
            width: 560px !important;
            text-align: center;
        }

        td[class="viewWebsite"] {
            width: 560px !important;
            height: inherit !important;
            text-align: center;
        }

    }

    @media only screen and (min-width: 250px) and (max-width: 480px) {

        td[class="Logo"] {
            width: 480px !important;
            text-align: center;
        }

        td[class="viewWebsite"] {
            width: 480px !important;
            height: inherit !important;
            text-align: center;
        }

        td[class="spacer"] {
            display: none !important;
        }

        td[class="bodyCopy"] p {
            padding: 0 15px !important;
            text-align: left !important;
        }

        td[class="bodyCopy"] h1 {
            padding: 0 10px !important;
        }

        h1, h2 {
            line-height: 120% !important;
        }

        td[class="force-width"] {width: 98% !important; padding: 0 10px;}

        [class="consoleImage"] {
            display: inline-block;
        }

        [class="consoleImage"] img {
            text-align: center !important;
            display: inline-block;
        }

        table[class="belowConsoles"] {
            text-align: center;
            float: none;
            margin-bottom: 15px;
            width: 100% !important;
        }

        table[class="belowConsoles"] img {
            margin-bottom: 0;
        }

    }
</style>
<html>

<body bgcolor="#f6f6f6" style="font-family: Arial; background-color: #f6f6f6;">


<table width="630" height="450" bgcolor="#fcfcfc" style="border: 1px solid #dddddd; line-height: 135%;" class="container" align="center" cellpadding="0" cellspacing="0">

    <tr>
        <td bgcolor="#fcfcfc" colspan="3">
            <table>
                <tr>
                    <td width="30" class="spacer">&nbsp;</td>
                    <td align="center" class="bodyCopy">
                        <h1 style="font-family: Arial, Helvetica, sans-serif; font-size: 32px; color: #404040; margin-top: 0; margin-bottom: 20px; padding: 0; line-height: 135%" class="headline">
                            <img  style="width: 30%;" src="{{ Storage::disk('public')->url(setting('admin.icon_image')) }}">
                        </h1>
                        <h1 style="font-family: Arial, Helvetica, sans-serif; font-size: 32px; color: #404040; margin-top: 0; margin-bottom: 20px; padding: 0; line-height: 135%" class="headline">Thanks for making an order with these details </h1>
                        <p style="font-family: Arial, Helvetica, sans-serif; color: #555555; font-size: 14px; padding: 0 40px;">Car Number : {{ $car_num }}</p>
                        <p style="font-family: Arial, Helvetica, sans-serif; color: #555555; font-size: 14px; padding: 0 40px;">Liters  : {{ $litres }}</p>
                        <p style="font-family: Arial, Helvetica, sans-serif; color: #555555; font-size: 14px; padding: 0 40px;">Price  : {{ $price }}</p>
                        <p style="font-family: Arial, Helvetica, sans-serif; color: #555555; font-size: 14px; padding: 0 40px;">Type  : {{ $gas_type }}</p>
                        <p style="font-family: Arial, Helvetica, sans-serif; color: #555555; font-size: 14px; padding: 0 40px;">Details  : {{ $details }}</p>
                    </td>
                    <td width="30" class="spacer">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>


</body>
</html>
