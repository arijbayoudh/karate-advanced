function fn() {

	/* =========================
       ENVIRONMENT MANAGEMENT
       ========================= */

	var env = karate.env; // valeur passée par -Dkarate.env
	if (!env) {
		env = 'recette'; // environnement par défaut
	}

	karate.log('Karate environment is:', env);

	var config = {};

	if (env === 'recette') {
		config.baseUrl = 'https://jsonplaceholder.typicode.com/';
	}
	else if (env === 'preprod') {
		config.baseUrl = 'https://jsonplaceholder.typicode.com/';
	}
	else if (env === 'prod') {
		config.baseUrl = 'https://jsonplaceholder.typicode.com/';
	}

	/* =========================
       HTTP STATUS
       ========================= */

	config.httpStatus = read('classpath:features/data/status/http-status.json');

	/* =========================
       RANDOM HELPERS
       ========================= */

	config.randomEmail = function () {
		return 'user_' +
			Date.now
			() + '_' +
			Math.random().toString(36).substring(2, 10) + '@example.com';
	};

	config.randomName = function () {
		var names = ['Alice', 'Bob', 'Charlie', 'David', 'Eva', 'Frank', 'Grace', 'Hannah'];
		return names[Math.floor(Math.random() * names.length)] + '_' +
			Math.random().toString(36).substring(2, 6);
	};

	config.randomUsername = function () {
		return 'user_' + Math.random().toString(36).substring(2, 10);
	};

	config.randomCity = function () {
		var cities = ['Paris', 'Lyon', 'Marseille', 'Tunis', 'Berlin', 'Madrid', 'Rome'];
		return cities[Math.floor(Math.random() * cities.length)];
	};

	config.randomAddress = function () {
		var streets = ['Rue de la Paix', 'Avenue Habib Bourguiba', 'Champs-Élysées', 'Main Street'];
		return Math.floor(Math.random() * 200) + ' ' +
			streets[Math.floor(Math.random() * streets.length)];
	};

	config.randomZipCode = function () {
		return Math.floor(10000 + Math.random() * 90000).toString();
	};

	config.randomPhone = function () {
		return '+33' + Math.floor(600000000 + Math.random() * 399999999);
	};

	config.randomCompany = function () {
		var companies = ['Google', 'Amazon', 'OpenAI', 'Microsoft', 'Meta'];
		return companies[Math.floor(Math.random() * companies.length)];
	};

	return config;
}