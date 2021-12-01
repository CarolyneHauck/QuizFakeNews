# Quiz_fake_news

● AuthCheck() é a classe responsável por verificar se existe algum usuário logado, caso sim redirecionar para a view de ClassicQuestionQuizzler e caso não direcionar para a View de Login.
● Login (View) é a classe que apresenta uma interface visual para o usuário acessar o jogo.
● Cadastro (View) é a classe que apresenta uma interface visual para o usuário criar seu
cadastro no jogo.
● ControllerLevel1 é a classe que controla o fluxo da
ClassicQuestion, ela é responsável por direcionar para as views de Error, Loading ou
ClassicQuestionQuizzler, dependendo do retorno do ClassicQuestionRepository.
● Loading (View) é a classe que apresenta uma interface visual de "carregando" enquanto é feita a busca das questões clássicas no banco de dados do firebase.
 ● ClassicQuestionRepository é uma classe que contém o padrão de projeto repository que permite um encapsulamento da lógica de acesso a dados, contém a função que faz o request para o firebase pegando as questões clássicas e transforma esse dado em um < List<ClassicQuestion >>.
● Error (View) é a classe que apresenta uma interface visual para o usuário tentar novamente, é apresentado quando ocorre um erro ao retornar os dados do firebase.
● ClassicQuestionQuizzler (View) é a classe que apresenta uma interface visual para o usuário acessar o jogo, apresentando as questões clássicas, assim como um time, as alternativas, e opções como pulas, parar e acertar.
● ClassicQuestion (Model) descreve a estrutura de dados utilizada pelo ClassicQuestionQuizzler, primeiro nível do jogo.
● GameOver (View) é a classe que apresenta uma interface visual para o usuário que perdeu o jogo e dar a opção de tentar novamente.
● TimeIsUp (View) é a classe que apresenta uma interface visual para o usuário que perdeu o jogo por tempo esgotado e dar a opção de tentar novamente.
● StartAgain (View) é a classe que apresenta uma interface visual para o usuário que perdeu o jogo por tempo esgotado e dar a opção de tentar novamente.
● ControllerLevel2 é a classe que controla o fluxo da
ClassicQuestionWithImage, ela é responsável por direcionar para as views de Error, Loading ou ClassicQuestionWithImageQuizzler, dependendo do retorno do ClassicQuestionWithImageRepository, é similar com a lógica do ControllerLevel1.
  
![login_cadastro](https://user-images.githubusercontent.com/33502583/144151769-de082f9a-4924-469f-b5a7-add5289a8002.gif)
![level1-ranking (1)](https://user-images.githubusercontent.com/33502583/144151775-29ef9f77-e5ed-4750-8646-955d25a3a84d.gif)
![feedback-erro-1](https://user-images.githubusercontent.com/33502583/144151791-4af98db4-e8a8-4398-9667-ff121aea0341.gif)
![level2](https://user-images.githubusercontent.com/33502583/144151793-cd529d82-9e5f-4de7-840f-2c3018d59e2c.gif)
![final](https://user-images.githubusercontent.com/33502583/144151801-45a3b48d-eccb-4e13-96aa-be9701776563.gif)
