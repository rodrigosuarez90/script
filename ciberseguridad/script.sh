#!/bin/bash

# Script de Práctica de DNS para Clases
# Autor: [Tu Nombre]
# Fecha: $(date)

echo "=========================================="
echo "      PRÁCTICA DE DNS - LABORATORIO"
echo "=========================================="
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar secciones
section() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

# Función para mostrar resultados
result() {
    echo -e "${GREEN}[RESULTADO]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[ADVERTENCIA]${NC} $1"
}

# Verificar dependencias
check_dependencies() {
    section "VERIFICANDO DEPENDENCIAS"
    
    commands=("dig" "nslookup" "host" "whois")
    
    for cmd in "${commands[@]}"; do
        if command -v $cmd &> /dev/null; then
            result "$cmd encontrado"
        else
            error "$cmd no está instalado"
        fi
    done
}

# Consultas DNS básicas
basic_queries() {
    section "CONSULTAS DNS BÁSICAS"
    
    domains=("google.com" "github.com" "wikipedia.org")
    
    for domain in "${domains[@]}"; do
        echo "Consultando: $domain"
        echo "---"
        
        # Consulta A record
        echo "Registro A:"
        dig +short A $domain
        
        # Consulta MX
        echo "Registro MX:"
        dig +short MX $domain
        
        # Consulta NS
        echo "Servidores NS:"
        dig +short NS $domain
        
        echo ""
    done
}

# Consultas avanzadas con dig
advanced_dig() {
    section "CONSULTAS AVANZADAS CON DIG"
    
    domain="example.com"
    
    echo "Consulta completa de DNS:"
    dig $domain ANY
    
    echo -e "\nConsulta con servidor DNS específico (8.8.8.8):"
    dig @8.8.8.8 $domain
    
    echo -e "\nConsulta reversa (PTR):"
    ip="8.8.8.8"
    dig -x $ip +short
}

# Comparación de herramientas DNS
compare_tools() {
    section "COMPARACIÓN DE HERRAMIENTAS DNS"
    
    domain="ubuntu.com"
    
    echo "Usando DIG:"
    dig +short A $domain
    
    echo -e "\nUsando NSLOOKUP:"
    nslookup $domain
    
    echo -e "\nUsando HOST:"
    host $domain
}

# Resolución de DNS inversa
reverse_lookup() {
    section "RESOLUCIÓN DNS INVERSA"
    
    ips=("8.8.8.8" "1.1.1.1" "9.9.9.9")
    
    for ip in "${ips[@]}"; do
        echo "Resolución inversa para: $ip"
        host $ip
        echo ""
    done
}

# Tiempos de respuesta DNS
dns_timing() {
    section "TIEMPOS DE RESPUESTA DNS"
    
    domain="kernel.org"
    dns_servers=("8.8.8.8" "1.1.1.1" "208.67.222.222")
    
    for server in "${dns_servers[@]}"; do
        echo "Probando servidor DNS: $server"
        time dig @$server $domain > /dev/null 2>&1
        echo ""
    done
}

# Consulta de registros específicos
specific_records() {
    section "REGISTROS ESPECÍFICOS"
    
    domain="microsoft.com"
    
    record_types=("A" "AAAA" "MX" "TXT" "SOA" "CNAME")
    
    for record in "${record_types[@]}"; do
        echo "Registro $record para $domain:"
        dig +short $record $domain
        echo ""
    done
}

# Troubleshooting DNS
dns_troubleshooting() {
    section "SOLUCIÓN DE PROBLEMAS DNS"
    
    problem_domain="este-dominio-no-existe-12345.com"
    
    echo "Intentando resolver dominio inexistente:"
    dig $problem_domain
    
    echo -e "\nVerificando conectividad DNS:"
    # Verificar si podemos resolver nombres
    if dig +short google.com > /dev/null; then
        result "DNS funcionando correctamente"
    else
        error "Problemas con la resolución DNS"
    fi
}

# Información WHOIS
whois_info() {
    section "INFORMACIÓN WHOIS"
    
    domain="python.org"
    
    echo "Obteniendo información WHOIS para: $domain"
    
    if command -v whois &> /dev/null; then
        whois $domain | head -20
    else
        warning "whois no está disponible"
    fi
}

# Práctica de subdominios
subdomain_practice() {
    section "PRÁCTICA DE SUBDOMINIOS"
    
    base_domain="github.com"
    subdomains=("docs" "api" "help" "status")
    
    for sub in "${subdomains[@]}"; do
        full_domain="$sub.$base_domain"
        echo "Consultando: $full_domain"
        ip=$(dig +short A $full_domain)
        if [ -n "$ip" ]; then
            result "$full_domain -> $ip"
        else
            warning "$full_domain no resuelve"
        fi
    done
}

# Menú principal
main_menu() {
    section "MENÚ PRINCIPAL"
    
    echo "Selecciona una opción:"
    echo "1) Verificar dependencias"
    echo "2) Consultas DNS básicas"
    echo "3) Consultas avanzadas con dig"
    echo "4) Comparar herramientas DNS"
    echo "5) Resolución DNS inversa"
    echo "6) Tiempos de respuesta DNS"
    echo "7) Consultar registros específicos"
    echo "8) Solución de problemas DNS"
    echo "9) Información WHOIS"
    echo "10) Práctica de subdominios"
    echo "11) Ejecutar todas las prácticas"
    echo "0) Salir"
    echo ""
    read -p "Ingresa tu opción (0-11): " choice
    
    case $choice in
        1) check_dependencies ;;
        2) basic_queries ;;
        3) advanced_dig ;;
        4) compare_tools ;;
        5) reverse_lookup ;;
        6) dns_timing ;;
        7) specific_records ;;
        8) dns_troubleshooting ;;
        9) whois_info ;;
        10) subdomain_practice ;;
        11) 
            check_dependencies
            basic_queries
            advanced_dig
            compare_tools
            reverse_lookup
            dns_timing
            specific_records
            dns_troubleshooting
            whois_info
            subdomain_practice
            ;;
        0) 
            echo "¡Hasta luego!"
            exit 0
            ;;
        *) 
            error "Opción no válida"
            ;;
    esac
    
    echo ""
    read -p "Presiona Enter para continuar..."
    clear
    main_menu
}

# Inicialización
clear
echo "Bienvenido al Laboratorio de Práctica de DNS"
echo "Este script te ayudará a aprender sobre:"
echo "- Resolución DNS"
echo "- Diferentes tipos de registros"
echo "- Herramientas de diagnóstico"
echo "- Solución de problemas"
echo ""

# Verificar si estamos en modo interactivo
if [ "$1" == "--auto" ]; then
    echo "Ejecutando en modo automático..."
    check_dependencies
    basic_queries
    advanced_dig
else
    main_menu
fi