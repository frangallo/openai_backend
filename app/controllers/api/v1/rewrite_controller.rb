module Api
  module V1
    class RewriteController  < ApiController
      def rewrite
       @response = ChatgptService.call(params[:text], params[:tone], params[:length])
       render json: @response
     end
    end
  end
end
