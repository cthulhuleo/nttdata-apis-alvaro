function fn() {
    var env = karate.env || 'dev';
    var config = {
        env: env,
        baseUrl: 'https://petstore.swagger.io',
        apiKey: 'special-key',
        timeout: 10000  // Aumentar a 10 segundos
    };

    // Configuración específica por entorno
    if (env === 'dev') {
        config.baseUrl = 'https://petstore.swagger.io';
    } else if (env === 'qa') {
        config.baseUrl = 'https://petstore.swagger.io';
    } else if (env === 'prod') {
        config.baseUrl = 'https://petstore.swagger.io';
    }

    // Configurar logging
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
    karate.configure('connectTimeout', config.timeout);
    karate.configure('readTimeout', config.timeout);

    // Para debugging
    karate.configure('printEnabled', true);
    karate.configure('report', {
        showLog: true,
        showAllSteps: true
    });

    return config;
}