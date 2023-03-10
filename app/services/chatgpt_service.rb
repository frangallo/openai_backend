class ChatgptService
  include HTTParty

  attr_reader :api_url, :options, :model, :message

  def initialize(text, tone, length, model = 'gpt-3.5-turbo')
    api_key = Rails.application.credentials.chatgpt_api_key
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @message = "Your task is to rewrite the following sentence in a #{tone} tone, make it the best sentence anyone has ever read, and provide 5 responses. Your responses should be creative and unique, but still capture the essence of the original sentence. The length of the response should be #{length}. Return the responses as an ordered list. Original Sentence: #{text}"

  end

  def call
    body = {
      model:,
      messages: [{ role: 'user', content: message}],
      temperature: 0.7,
      max_tokens: 256,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 10)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end

  class << self
    def call(text, tone, length, model = 'gpt-3.5-turbo')
      new(text, tone, length, model).call
    end
  end
end
