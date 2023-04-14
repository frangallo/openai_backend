module Api
  module V1
    class ChatgptController  < ApiController
      def ask
       @response = Chatgpt4Service.call(params[:prompt])
       render json: {content: @response}
     end
    end
  end
end
