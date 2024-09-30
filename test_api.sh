# curl https://api.gptsapi.net/v1/chat/completions \
curl https://api1.uiuiapi.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer sk-boc9fQCk8STTy8jy840239711dBb4c3dAb6d8319Be747eD2" \
    -d '{ "model": "gpt-4o-mini", "messages": [ { "role": "user", "content": "Hello!" } ], "logprobs": true, "top_logprobs": 5}'