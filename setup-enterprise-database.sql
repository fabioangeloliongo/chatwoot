-- Script para criar database separado para Chatwoot Enterprise
-- Execute este script no PostgreSQL antes do deploy

-- Conectar ao PostgreSQL
\c postgres;

-- Criar database para Chatwoot Enterprise (separado da versão normal)
CREATE DATABASE chatwoot_enterprise;

-- Conectar ao novo database
\c chatwoot_enterprise;

-- Criar extensão pgvector (necessária para Captain AI)
CREATE EXTENSION IF NOT EXISTS vector;

-- Verificar se a extensão foi criada
SELECT * FROM pg_extension WHERE extname = 'vector';

-- Conceder permissões ao usuário postgres
GRANT ALL PRIVILEGES ON DATABASE chatwoot_enterprise TO postgres;

-- Mostrar databases existentes
\l
