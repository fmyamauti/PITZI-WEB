class UserController < ApplicationController
    def index
    end

    def add 
        add_user(params[:cpf],params[:name],params[:email])
    end

    private

    def post_api(url)        
        response = Excon.post(          
          url
        )

       result = JSON.parse(response.body)

       if response.status == 201
        flash[:notice] = 'Cliente incluído com sucesso'        
       else
        flash[:notice] = result['message'] 
       end
    end    

    def get_api(url)
        response = Excon.get(          
            url
          )
  
          return nil if response.status != 200
  
         JSON.parse(response.body)
    end

    def add_user(cpf,name,email) 
      post_api("http://localhost:3000/users/?cpf=#{URI.encode(cpf)}&name=#{URI.encode(name)}&email=#{URI.encode(email)}")
      users = get_users()
 
      session[:users] = users

      redirect_to root_url
    end

    def get_users() 
        get_api("http://localhost:3000/users")
    end
    
  end