class OrderController < ApplicationController
    def index
    end

    def create 
        create_order(params[:device_model],params[:imei],params[:annual_price],params[:installment_no],params[:user_id])
    end

    private

    def post_api(url)        
        response = Excon.post(          
          url
        )
 
        result = JSON.parse(response.body)

       if response.status == 201
        flash[:notice] = 'Assinatura incluída com sucesso'        
       else
        flash[:notice] = result['message'] 
       end
    end    

    def create_order(device_model,imei,annual_price,installment_no,user_id) 
      post_api("http://localhost:3000/users/#{URI.encode(user_id)}/orders?device_model=#{URI.encode(device_model)}&imei=#{URI.encode(imei)}&annual_price=#{URI.encode(annual_price)}&installment_no=#{URI.encode(installment_no)}")
      redirect_to root_url
    end
  end