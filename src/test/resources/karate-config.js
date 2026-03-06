function fn() {
    var env = karate.env || 'dev';
    var config = {
        env: env,
        baseUrl: 'https://petstore.swagger.io',
        apiKey: 'special-key'
    };

    // Configuración específica por entorno
    if (env === 'dev') {
        config.baseUrl = 'https://petstore.swagger.io';
    }

    // Configurar logging
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout', 10000);
    karate.configure('printEnabled', true);

    return config;
}