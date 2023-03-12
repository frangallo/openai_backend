module Api
  module V1
    class RewriteController  < ApiController
      def rewrite
       @response = ChatgptService.call(params[:text], params[:formality], params[:tone], params[:length])
       render json: {content: @response}
     end
    end
  end
end
