# 🚀 bash-pm2

**Gerenciador de processos profissional para usuários sem sudo**

Mantenha seus scripts, servidores e aplicações rodando 24/7 com auto-restart, monitoramento e logs. Tudo sem precisar de permissões root!

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/bash-5.0+-blue.svg)](https://www.gnu.org/software/bash/)

## ✨ Features

- ✅ **Sem sudo** - Roda no nível do usuário com systemd user
- 🔄 **Auto-restart** - Reinicia automaticamente se o processo cair
- 🚀 **Boot 24/7** - Inicia automaticamente no login e persiste após logout
- 📊 **Status Rico** - Monitora uptime, PID, restarts e estado
- 📝 **Logs Avançados** - stdout/stderr separados com `tail -f`
- 🎨 **Interface Colorida** - Output profissional e legível
- ⚡ **Leve** - Apenas bash puro, sem dependências extras

## 📦 Instalação (One-Line)

```bash
curl -fsSL https://raw.githubusercontent.com/lhabacuc/bash-pm2/main/install.sh | bash
```

Isso vai:
1. Baixar o script para `~/bin/bash-pm2`
2. Criar o serviço systemd do usuário
3. Habilitar auto-start no boot
4. Configurar tudo automaticamente

### Instalação Manual

```bash
# 1. Clone o repositório
git clone https://github.com/lhabacuc/bash-pm2.git
cd bash-pm2

# 2. Execute a instalação
bash bash-pm2.sh install

# 3. Recarregue o PATH (ou abra novo terminal)
export PATH="$HOME/bin:$PATH"
```

## 🎯 Uso Rápido

```bash
# Iniciar um processo
bash-pm2 start "python -m http.server 8080" --name webserver
bash-pm2 start "node app.js" -n api

# Listar todos os processos
bash-pm2 list

# Status detalhado de um processo
bash-pm2 status api

# Ver logs em tempo real
bash-pm2 logs api -f

# Ver logs de erro
bash-pm2 logs api --err

# Reiniciar processo
bash-pm2 restart api

# Parar processo
bash-pm2 stop api

# Remover do gerenciador
bash-pm2 delete api
```

## 📚 Comandos Completos

### Gerenciamento de Processos

| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `start` | Inicia um novo processo | `bash-pm2 start "npm run dev" --name frontend` |
| `stop` | Para um processo | `bash-pm2 stop frontend` |
| `restart` | Reinicia um processo | `bash-pm2 restart frontend` |
| `delete` | Remove do gerenciador | `bash-pm2 delete frontend` |

### Monitoramento

| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `list` ou `ls` | Lista todos os processos | `bash-pm2 list` |
| `status` | Status geral ou de um processo | `bash-pm2 status api` |
| `logs <nome>` | Mostra logs (últimas 50 linhas) | `bash-pm2 logs api` |
| `logs <nome> -f` | Segue logs em tempo real | `bash-pm2 logs api -f` |
| `logs <nome> -n 100` | Mostra últimas N linhas | `bash-pm2 logs api -n 100` |
| `logs <nome> --err` | Mostra apenas erros | `bash-pm2 logs api --err` |

### Sistema

| Comando | Descrição |
|---------|-----------|
| `info` | Informações do sistema bash-pm2 |
| `flush` | Limpa todos os logs |

## 📊 Exemplo de Output

```bash
$ bash-pm2 list

bash-pm2 status:

NAME                 STATUS   UPTIME     RESTARTS     PID
────────────────────────────────────────────────────────────
webserver            online   2h 15m     restarts:0   PID:1234
api                  online   5d 3h      restarts:2   PID:5678
worker               stopped
```

```bash
$ bash-pm2 status api

● api
   Status:    online
   PID:       5678
   Uptime:    5d 3h
   Restarts:  2
   Command:   node app.js
   Log:       /home/user/.bash-pm2/logs/api.log
```

## 🔧 Como Funciona

1. **Daemon Systemd**: Um serviço do usuário monitora processos a cada 5s
2. **Auto-restart**: Se um processo cai, é reiniciado automaticamente
3. **Persistência**: Configurações salvas em `~/.bash-pm2/config`
4. **Logs**: stdout em `*.log`, stderr em `*.err.log`
5. **PIDs**: Rastreados em `~/.bash-pm2/pids/*.pid`

### Estrutura de Arquivos

```
~/.bash-pm2/
├── config          # Comandos salvos
├── metadata        # Uptime, restarts, etc
├── pids/           # Arquivos PID
│   ├── api.pid
│   └── webserver.pid
└── logs/           # Logs dos processos
    ├── api.log
    ├── api.err.log
    ├── webserver.log
    └── webserver.err.log
```

## 🛠️ Gerenciamento do Daemon

```bash
# Ver status do daemon
systemctl --user status bash-pm2

# Parar daemon (para manutenção)
systemctl --user stop bash-pm2

# Reiniciar daemon
systemctl --user restart bash-pm2

# Ver logs do daemon
journalctl --user -u bash-pm2 -f

# Desabilitar auto-start
systemctl --user disable bash-pm2
```

## 💡 Casos de Uso

### Servidor Web de Desenvolvimento
```bash
bash-pm2 start "python -m http.server 8000" --name devserver
```

### API Node.js
```bash
bash-pm2 start "node server.js" --name api
bash-pm2 logs api -f
```

### Worker Python
```bash
bash-pm2 start "python worker.py" --name queue-worker
```

### Múltiplos Ambientes
```bash
bash-pm2 start "npm run dev" --name frontend-dev
bash-pm2 start "npm run start:staging" --name api-staging
bash-pm2 start "npm run start:prod" --name api-prod
```

## 🔒 Segurança

- ✅ Roda apenas com permissões do usuário
- ✅ Não precisa de sudo ou root
- ✅ Isolado por usuário (não afeta outros usuários)
- ✅ Logs privados em `~/.bash-pm2/`

## 🐛 Troubleshooting

### Processo não inicia
```bash
# Verifique os logs de erro
bash-pm2 logs nome --err

# Verifique se o comando funciona manualmente
bash -c "seu comando aqui"
```

### Daemon não está ativo
```bash
# Reinicie o daemon
systemctl --user restart bash-pm2

# Verifique logs do systemd
journalctl --user -u bash-pm2 --no-pager -n 50
```

### Processos não persistem após logout
```bash
# Habilite linger (precisa de sudo)
sudo loginctl enable-linger $USER

# Verifique se está habilitado
loginctl show-user $USER | grep Linger
```

### PATH não encontra bash-pm2
```bash
# Adicione ao PATH manualmente
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## 📋 Requisitos

- Bash 4.0+
- systemd
- curl (apenas para instalação)
- Linux (testado em Ubuntu, Debian, CentOS)

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Add nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abrir um Pull Request

## 📝 License

MIT License - veja [LICENSE](LICENSE) para detalhes.

## 🙏 Inspiração

Inspirado pelo [PM2](https://pm2.keymetrics.io/) para Node.js, mas feito em bash puro para ser universal e sem dependências.

## 📞 Suporte

- 🐛 **Issues**: [GitHub Issues](https://github.com/lhabacuc/bash-pm2/issues)
- 💬 **Discussões**: [GitHub Discussions](https://github.com/SEU-USER/bash-pm2/discussions)

---

⭐ **Se este projeto foi útil, considere dar uma estrela no GitHub!**
