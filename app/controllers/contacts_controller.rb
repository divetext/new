class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end

    def confirm
        @contact = Contact.new(contact_params)
       if @contact.valid?
          render :action => "confirm"
       else
           render :action => "new"
       end
    end
    
    def create
        @contact = Contact.new(contact_params)
        if params[:back]
            render :action => "new"
        elsif @contact.save
            redirect_to root_path, notice: "お問い合わせありがとうございます！"
        else
            redirect_to root_path, notice: "お問い合わせありがとうございます！"
        end
    end
    
    private
    def contact_params
        params.require(:contact).permit(:name, :email, :content)
    end
end
