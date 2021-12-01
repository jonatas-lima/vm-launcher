# VM-Launcher

## Motivação
- Repositório destinado ao estudo de automatizações e sobre o provisionamento de máquinas virtuais utilizando Vagrant

___
## Tecnologias utilizadas

- Docker
- Vagrant
- Shell script
- MySQL
- Zabbix (agent)
- VirtualBox
- iperf3

___
## O que faz?
- Ao executar o script `deploy.sh`, serão criadas as instâncias definidas no arquivo `vms.csv` com o Vagrant, cada uma com um banco de dados pré-configurado e com o Zabbix agent.

___
## Como configurar?
1. No arquivo `vms.csv` devem ser colocadas as seguintes informações:
  
| Hostname | Endereço de IP | Interface de rede | Memória (MB) | Número de VCPU's
| - | - | - | - | - |

- Especificar a interface de rede do seu dispositivo permite que a VM possa se conectar com ele no modo 'bridge'
  
- Para saber qual a interface de rede do seu dispositivo, digite no terminal:
```bash 
ip link show (ou simplesmente ip l)
``` 
2. No arquivo `launch_mysql_container.sh` devem ser definidas (se quiser) as variáveis de acesso ao banco de dados
   
3. No arquivo `install_and_config_zabbix_agent.sh` o valor da variável `ZABBIX_SERVER_IP` deve ser alterada para o IP do seu servidor Zabbix
  
4. Executar o script `deploy.sh`

## Requisitos para testar
- Instalar o [Vagrant](https://www.vagrantup.com/downloads)
- Instalar o [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Ter uma instância do [Zabbix Server rodando](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwj_msTj9MD0AhUfD7kGHSOcB4QQwqsBegQIKxAB&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DO8KIZ3N2_L4&usg=AOvVaw17kfRAJyRY49x0DGZF1F2e)

___
## Como funciona?
- Serão criados arquivos especiais Vagrantfile, que possuem as configurações de hardware e de provisionamento da VM a ser subida por meio do VirtualBox e, durante esse provisionamento, o Zabbix agent será instalado e configurado de acordo com as especificações dadas, será instalado também o iperf3 e será colocado para rodar seu servidor em modo daemon (em background).
  
- Além do Zabbix agent, também é instalado o Docker e lançado um container MySQL com as configurações definidas no arquivo `launch_mysql_container.sh`

- São "upados" ainda, dois scripts para auxiliar no monitoramento da rede e dos dispositivos.

> 1. `generate_udp_traffic.sh`: Como o nome já diz, esse script simula tráfego UDP entre duas máquinas através da ferramenta **iperf**, a qual funciona no modelo cliente-servidor. Esse script faz a máquina funcionar como cliente, sendo necessário especificar nesse mesmo script o IP do servidor iperf
   
> 2. `get_rtt.sh`: Esse script realiza o monitoramento do RTT (Round Trip Time - popularmente conhecido como 'ping') médio do link entre duas máquinas. Conforme esse script é executado, esses dados são salvos no banco de dados criado anteriormente

- Esses dois scripts somente funcionam se forem passados um parâmetro, que é o tempo do teste em segundos (para o primeiro script) e a quantidade de pacotes ICMP enviados (para o segundo script)
  - `bash generate_udp_traffic.sh 300` (Simula tráfego UDP por 300s = 5min)

- Para executar os scripts, basta navegar até a pasta da Vagrantfile da VM que você queira executar o script e rodar `vagrant ssh`. Com isso, você se conectará à máquina e poderá rodar os scripts com as orientações dadas acima

## Como visualizar?
- Feito os passos anteriores, na sua instância do Zabbix server, devem ser configurados os hosts a serem monitorados e selecionados os items ou templates de métricas para a criação dos dashboards. Eu utilizo, na maioria das vezes, o template específico para o SO Linux, que dá várias métricas como o uso de disco, uso de CPU, tráfego de rede, entre outros.

- Para visualizar os dados de RTT, eu indico instalar o [Grafana](https://grafana.com/docs/grafana/latest/installation/), uma ferramenta que permite a criação de dashboards a partir de uma data source. Deve ser configurado uma data source MySQL e colocar as configurações que foram colocadas no arquivo de inicialização do container MySQL. Após isso, vai em criar dashboard e criar um novo painel, onde terá a opção de selecionar a data source e a tabela (ping_stats), assim como o campo de tempo (created_at) e o campo de valor (rtt). Após fazer isso, será criado um dashboard com esses dados.
  
## Cron jobs
- Se quiser aumentar o nível de veracidade desse teste, seria interessante criar cron jobs (tasks que são executadas de tempos em tempos) para executar os scripts que foram fornecidos. Deixo aqui uma referência legal sobre [como criar cron jobs](https://help.dreamhost.com/hc/en-us/articles/215767047-Creating-a-custom-Cron-Job)
