# E-Commerce

Diagrama para E-Commerce altamente disponível, escalável, segura e com custo otimizado

![Diagrama E-Commerce](./E-commerce.PNG)

1. AWS Shield Standard ativado por padrão na maioria dos serviços da AWS, para proteger contra ataques DDoS.

2. Route 53 atende as solicitações de DNS do usuário de forma escalável e com proteção já inclusa no serviço contra DDoS, ataques de amplificação e outros ataques de DNS. Com o roteamento de failover, quando ocorre alguma interrupção, o serviço direciona os usuários para um local alternativo, como o Application Load Balancer para outra zona de disponibilidade ou, como failover secundário, um site estático hospedado no bucket do S3. 

3. O CloudFront, que terá o AWS WAF aplicado para maior proteção contra ataques de injeção SQL e XSS (Cross-Site Scripting), recebe a solicitação e entrega conteúdo estático armazenado em cache e próximo ao usuário, para menor latência da aplicação. 
Caso ocorra indisponibilidade, direciona o tráfego para o site estático no S3 conforme configurado como failover secundário no Route 53.

4. Para conteúdo dinâmico, como páginas de produtos ou carrinhos de compras, o usuário é direcionado pelo Application Load Balancer para as instâncias EC2 de frontend em grupos de Auto Scaling, que farão o processamento das requisições do usuário e da renderização do site. Conforme a demanda aumenta, o usuário pode ser direcionado para qualquer uma das duas zonas de disponibilidade, para maior disponibilidade do site.
Aplicamos o AWS WAF no ALB para protegermos contra ataques OWASP Top 10, mitigação de bots e crawlers e outros tipos.

5. De forma automatizada, o Application Load Balancer checa a integridade das instâncias e aciona o Auto Scaling para aumentar ou diminuir o número de instâncias EC2, tornando a aplicação elástica à demanda.

6. Para os processamentos de pedidos de compra, entra o Amazon SQS, que envia como mensagem o pedido de compra feito pelo usuário para a Fila de Pedidos.
É utilizado o SQS para os pedidos em vez do Application Load Balancing, para garantir que os pedidos sejam processados de forma assíncrona, mais eficiente e com fim de evitar indisponibilidades no backend.

7. A Fila de Pedidos no SQS irá receber as mensagens do Frontend, encaminhará para o Backend e, caso ocorram mensagens que não puderam ser processadas corretamente, serão encaminhadas para a Fila de mensagens mortas (Dead-letter queue), para processamento posterior ou intervenção dos administradores.

8. As mensagens da Fila de Pedidos são recebidas pelo Backend (outra frota de instâncias EC2 com Auto Scaling), que irá processar os pedidos e iniciará a persistência dos mesmos no banco de dados. No passo 11, o Backend também atuará com os outros tipos de solicitações no site.

9. Na camada de banco de dados, teremos banco de dados SQL no RDS para armazenar os pedidos e outras informações, e banco de dados NoSQL no DynamoDB, para armazenar o catálogo de produtos.
O ElastiCache for Memcached terá em cache os dados mais acessados do banco RDS, para receber todas as solicitações de leitura e evitar sobrecarga do RDS.

10. Para solicitações de escrita dos pedidos de compra e outras solicitações para o banco SQL, o Backend grava as informações no RDS e alimenta o cache do ElastiCache for Memcached.

11. Para as outras transações, como cadastros de usuários e cadastros no catálogo de produtos, utilizamos o Application Load Balancing com AWS WAF em vez do SQS, para o Frontend enviar tais requisições ao Backend e depois armazenar nos bancos de dados.

12. Para operações de leitura no catálogo de produtos, usamos o ElastiCache for Redis para maior performance e menor sobrecarga de acesso no DynamoDB.

13. Para operações de gravação no catálogo de produtos, o Backend processa e armazena os dados no DynamoDB e no ElastiCache for Redis, para disponibilizar em cache o conteúdo recém gravado no banco.

## Pontos de atenção

1. Foi considerado o uso de 3 ou mais Zonas de Disponibilidade e Multi-Cloud. Porém como o foco também é no custo, foi decidido não utilizar tais recursos.

2. Os serviços AWS Shield Advanced e GuardDuty foram descartados devido ao custo (US$ 6000 ou mais/mês), porém podem ser re-considerados em cenários de maior faturamento do e-commerce.

3. Uso do DynamoDB será limitado nesse cenário devido ao custo.
Quantidade de gravações sob demanda por mês sobe US$75 para cada milhão de gravações sob demanda, com um custo inicial já em torno de US$ 600.
