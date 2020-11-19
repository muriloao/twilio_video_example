# Twilio Videocall Test

Projeto para teste de funcionamento do serviço de video chamada da Twilio
https://www.twilio.com/video

## Como utilizar

Para utilização do serviço é necessário um token de acesso dos serviços da Twilio. Este token é um JWT qeu pode ser gerado pelo link: https://www.twilio.com/console/video/project/testing-tools

Cada token é válido para um usuário por sessão, ao gerar o token deve ser informado a identificação/nome deste usuário e o nome da sala desejada.
Para cada usuário deve-se gerar um novo token, é possível gerar este token pela API do Twilio, veja mais em: https://www.twilio.com/console/video/project/testing-tools

Apos a geração do token, substitua o valor do mesmo na variável ```TWILIO_TOKEN``` na ```linha 10``` do ```main.dart```

Ao executar o projeto, um formulário será exibido, informe o nome de usuário e sala (mesmos que foram informados ao gerar o token) e o tipo de conexão, clique no botão para entrar na sala.
Lembrando que o nome de usuario e sala é extraído do token JWT informado no console da Twilio, este processo é feito internamente pela biblioteca da Twilio.

## Notas

A documentação da Twilio recomenda que a geração do token seja feita fora do app, por uma API, oque faz total sentido. No app de exemplo a geração do token é feita por uma backend no Cloud Functions do Google, neste caso como é somente um exemplo básico deixei o token como variável para que o utilizador decida como fazer a geração  do mesmo.

## Referencias

- [Twilio_ Programmable Video](https://pub.dev/packages/twilio_programmable_video)
- [Twilio_ Programmable Video Example](https://gitlab.com/twilio-flutter/programmable-video/-/tree/master/programmable_video/example)