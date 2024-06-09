# Use a imagem oficial do Ruby 3.3.0
FROM ruby:3.3.0

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock para o diretório de trabalho
COPY Gemfile Gemfile.lock ./

# Instale as dependências do Ruby
RUN bundle install

# Copie o restante dos arquivos do projeto para o diretório de trabalho
COPY . .

# Comando para iniciar a aplicação
CMD ["rails", "server", "-b", "0.0.0.0"]