local llamacpp = require('model.providers.llamacpp')

require('model').setup({
  default_prompt = "mistral",
  prompts = {
    mistral = {
      provider = llamacpp,
      options = {
        url = "http://127.0.0.1:8080"
      },
      builder = function(input, context)
        return {
          prompt =
              '<s>[INST]'
              .. input
              .. '[/INST]'
              .. context.args,
          stops = { '+' },
          temprature = 1.2,
          max_tokerns = 256,
        }
      end
    }
  }
})
