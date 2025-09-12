# Deploy Chatwoot Enterprise no Portainer

Este guia mostra como fazer o deploy da nossa versão customizada do Chatwoot Enterprise no Portainer.

## Pré-requisitos

- Portainer instalado e funcionando
- PostgreSQL com extensão pgvector instalada
- Redis instalado e funcionando
- Acesso aos dados de conexão do PostgreSQL e Redis

## Arquivos Criados

1. **docker-compose.portainer.yml** - Configuração dos serviços
2. **.env.production** - Variáveis de ambiente (template)

## Passos para Deploy

### 1. Preparar Database

No PostgreSQL, execute:
```sql
CREATE DATABASE chatwoot_production;
\c chatwoot_production;
CREATE EXTENSION IF NOT EXISTS vector;
```

### 2. Deploy no Portainer

1. **Acesse o Portainer**
2. **Vá em Stacks → Add Stack**
3. **Nome do Stack**: `chatwoot-enterprise`
4. **Upload** o arquivo `docker-compose.portainer.yml`
5. **Configure as Environment Variables**:
   - Copie as variáveis do `.env.production`
   - Ajuste os valores para seu ambiente
6. **Deploy the Stack**

### 3. Environment Variables

```
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
POSTGRES_DATABASE=chatwoot_production
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=d824c80a1c7b0f100d78c0084343dd15
REDIS_URL=redis://redis:6379
SECRET_KEY_BASE=6b92145b436002ab2c4955f65ecc6d8d64b84ac1574d35bab25f5a0314f19d82f0c55f5f4512ac9c32d3859387cf1e7ded549fd5cd8c7d0c6053964434522af4
FRONTEND_URL=http://seu-ip:3000
```

### 4. Verificar Deploy

Após o deploy, verifique:

```bash
# Logs do container web
docker logs chatwoot-web-custom

# Logs do container sidekiq
docker logs chatwoot-sidekiq-custom

# Status dos containers
docker ps | grep chatwoot
```

### 5. Acessar Aplicação

- **URL**: `http://seu-servidor:3000`
- **Super Admin**: Será criado automaticamente no primeiro acesso

## Recursos Enterprise Incluídos

✅ **Captain AI** - Assistente IA integrado com pgvector
✅ **SLA Policies** - Políticas de nível de serviço
✅ **Advanced Analytics** - Relatórios avançados
✅ **Team Management** - Gerenciamento de equipes
✅ **Custom Reports** - Relatórios personalizados
✅ **Advanced Search** - Busca avançada

---

**Nota**: Esta configuração inclui todas as customizações Enterprise que fizemos localmente, incluindo Captain AI e recursos avançados.
