/*
	Create the DB. Change name here
*/

CREATE DATABASE IF NOT EXISTS `curriculumsprojectdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `curriculumsprojectdb`;

/*
	Create tables
*/ 

CREATE TABLE .`users` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(256) NOT NULL , `email` VARCHAR(256) NOT NULL , `password` VARCHAR(256) NOT NULL ,
`role` VARCHAR(20) NOT NULL, PRIMARY KEY (`id`)) ENGINE = InnoDB; 

CREATE TABLE `curriculums` ( `id` INT NOT NULL AUTO_INCREMENT, `oks` VARCHAR(20) NULL , `specialty` VARCHAR(50) NOT NULL , `academicYear` VARCHAR(20) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;

CREATE TABLE `disciplines` ( `id` INT NOT NULL AUTO_INCREMENT, `disciplineNameBg` VARCHAR(100) NOT NULL , `disciplineNameEng` VARCHAR(100) DEFAULT NULL,
`specialtiesAndCourses` VARCHAR(500) DEFAULT NULL, `category` VARCHAR(50) NOT NULL, `oks` VARCHAR(50) NOT NULL ,`professor` VARCHAR(100) NOT NULL , `semester` VARCHAR(50) NOT NULL , `elective` VARCHAR(50) DEFAULT NULL , `credits` INT UNSIGNED NOT NULL , `annotation` TEXT NOT NULL , `prerequisites` TEXT NULL DEFAULT NULL , `expectations` TEXT NULL DEFAULT NULL , `content` TEXT DEFAULT NULL , `synopsis` TEXT DEFAULT NULL , `bibliography` TEXT DEFAULT NULL ,`code` VARCHAR(20) DEFAULT NULL, `administrativeInfo` TEXT DEFAULT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB; 

CREATE TABLE `curriculum_disciplines` ( `curriculumId` INT NOT NULL , `disciplineId` INT NOT NULL ) ENGINE = InnoDB;

CREATE TABLE `depend_by` ( `disciplineId` INT NOT NULL , `code` VARCHAR(20) NOT NULL ) ENGINE = InnoDB; 

/*
	Add constraints
*/

ALTER TABLE `curriculums` ADD UNIQUE `specialty` (`specialty`, `academicYear`, `oks`) USING BTREE;

ALTER TABLE `curriculum_disciplines` ADD CONSTRAINT `FK_curriculum_manytomany` FOREIGN KEY (`curriculumId`) REFERENCES `curriculums`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; 

ALTER TABLE `curriculum_disciplines` ADD CONSTRAINT `FK_disciplines_manytomany` FOREIGN KEY (`disciplineId`) REFERENCES `disciplines`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

CREATE TABLE `depends_on` ( `disciplineId` INT NOT NULL , `code` VARCHAR(20) NOT NULL ) ENGINE = InnoDB; 

ALTER TABLE `depends_on` ADD UNIQUE( `disciplineId`, `code`); 

ALTER TABLE `depend_by` ADD UNIQUE( `disciplineId`, `code`); 

CREATE TABLE `users_disciplines` (`userId` INT NOT NULL, `disciplineId` INT NOT NULL,
                                  Constraint PK_users_disciplines Primary Key (userId, disciplineId),
                                  CONSTRAINT FK_userid_id FOREIGN KEY (userId) REFERENCES Users(id),
                                  CONSTRAINT FK_disciplineid_id FOREIGN KEY (disciplineId) REFERENCES Disciplines(id));

/*
	Insert sample data - the info of three disciplines and several curriculums (bachelors and masters).
*/

INSERT INTO `disciplines` (`id`, `disciplineNameBg`, `disciplineNameEng`, `specialtiesAndCourses`, `category`, `oks`, `professor`, `semester`, `elective`, `credits`, `annotation`, `prerequisites`, `expectations`, `content`, `synopsis`, `bibliography`, `code`, `administrativeInfo`) VALUES (NULL, 'Операционни системи - практикум', 'OS-practice', '[{\"Софтуерно инженерство\": [\"2\"],\"Компютърни науки\": [\"2\"]}]', 'ОКН', '[\"Бакалавър\", \"Maгистър\"]', 'гл. ас. Георги Иванов Георгиев', 'Летен', 'избираема', '2', 'Дисциплината усъвършенства уменията по практическото използване на командния интерпретатор и системните  извиквания в стандарта POSIX.', 'Учебни дисциплини „Компютърни архитектури“ и „Увод в  програмирането“.', 'Студентите придобиватпрактически навици за:(1) Взаимодействие с ОС UNIX/Linux чрез команден език (shell).(2) Работа с езика C.(3) Работа с файлове и файлови дескриптори в стандарта POSIX.(4) Работа с комуникационни канали (pipe, socket).(5) Управление на процеси', '[
		"Основни команди в OS Linux (вградени + coreutils)", "Програмиране на shell.43Инструменти за работа с езика C в OS Linux -gcc, make.", "Системни извиквания за работа с файлове: open, close, read, write, lseek.", "Управление на процеси: fork, exec, exit, wait", "Работа с тръби и файлови дескриптори: pipe, dup", "Сокети: socket, bind, listen, accept, connect", "Асинхронни комуникации: fcntl, errno, select"
	]', '[\r\n		\"Команден интерпретатор в ОС UNIX/Linux. Основни команди.\", \"Комбиниране на команди –конвейри, паралелни задачи. Филтри. Файлова структура и имена, разширяване на метасимволи.\", \"Програмиране на команден език. Променливи, обкръжение. Управляващи команди. Командни процедури. \", \"Инструменти за работа с езика C в OS Linux -gcc, make.\", \"Системни извиквания за работа с файлове: open, close, read, write, lseek.\", \"Управление на процеси: fork, exec, exit, wait\", \"Работа с тръби и файлови дескриптори: pipe, dup\", \"Сокети: socket, bind, listen, accept, connect\", \"Асинхронни комуникации: fcntl, errno, select\"\r\n	]', '[\r\n		\"[1] Tanenbaum A.S. Operating Systems: Design and Implementation, 3nd ed., NJ: Pearson Prentice Hall, 2006.\", \"[2] Peterson J. L., Silberschatz A. Operating Systems Conceps, Addison-Wasley Publishing   Company Inc., 1985.\"\r\n	]', 'ОСПР123', '{\r\n		\"Утвърдена с решение на ФС с протокол\": \"№ 6 / 26.06.2017 г.\",\r\n		\"Утвърдил\": \"доц. П. Първанов\",\r\n		\"Катедра\": \"Изчислителни системи\"\r\n	}');

INSERT INTO `curriculums` (`id`, `oks`, `specialty`, `academicYear`) VALUES (NULL, 'Бакалавър', 'Софтуерно инженерство', '2018/2019'), (NULL, 'Магистър', 'Софтуерно инженерство', '2018/2019'), (NULL, 'Бакалавър', 'Софтуерно инженерство', '2019/2020'), (NULL, 'Магистър', 'Софтуерно инженерство', '2019/2020'), (NULL, 'Бакалавър', 'Компютърни науки', '2018/2019'), (NULL, 'Магистър', 'Компютърни науки', '2018/2019'), (NULL, 'Бакалавър', 'Компютърни науки', '2019/2020'),  (NULL, 'Магистър', 'Компютърни науки', '2019/2020');

INSERT INTO `curriculum_disciplines` (`curriculumId`, `disciplineId`) VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1);

INSERT INTO `depends_on` (`disciplineId`, `code`) VALUES ('1', 'УП123');

INSERT INTO `depend_by` (`disciplineId`, `code`) VALUES ('1', 'ООП123');

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES (NULL, 'admin', 'admin@fmi.uni-sofia.bg', '$2y$10$dLdmztKkcSdpbh4AvECMiuBRpjWyHn09aDchzsNKoBF7MXiYbUEbC', 'admin'), (NULL, 'regular_user', 'regular_user@abv.bg', '$2y$10$mXa88xx6PCmDHd.B1Gs71OuV2w8W8Om71QliJRRuhywmSubnYOLGe', ''); 

INSERT INTO `disciplines` (`id`, `disciplineNameBg`, `disciplineNameEng`, `specialtiesAndCourses`, `category`, `oks`, `professor`, `semester`, `elective`, `credits`, `annotation`, `prerequisites`, `expectations`, `content`, `synopsis`, `bibliography`, `code`, `administrativeInfo`) VALUES (NULL, 'Обектно-ориентирано програмиране', 'Object-oriented Programming', '[{\r\n \"Софтуерно инженерство\": [\"1\", \"2\", \"3\"],\r\n \"Компютърни науки\": [\"1\", \"2\", \"3\"],\r\n \"Информационни системи\": [\"1\", \"2\", \"3\"],\r\n \"Информатика\": [\"1\", \"2\", \"3\"],\r\n \"Mатематика и информатика\": [\"1\", \"2\", \"3\"]\r\n }]', 'ОКН', '[\"Бакалавър\"]', 'доц. Милен Петров', 'Летен', 'Избираема', '5', 'Курсът цели да опресни и обогати познанията на студентите с последните достижения в ООП или ако не са програмирали никога с обектно-ориентиран език - да ги въведе в един съвременен и понастоящем най-широко разпространен обектно-ориентиран език за разработка на софтуер в ИКТ. Курсът ще спомогне и на студентите с едни от основните предизвикателства към студентите и специалистите в областта на информационните и комуникационни технологии - да поддържат високо ниво на знанията и уменията си, като от една страна, това са познанието и прилагането на съвременните достижения в езиците за програмиране, а от друга – прилагането на съвременните технологии, инструменти, методи и средства за разработка на приложения.\r\n', 'Операционни системи: Линукс, основни познания за вътрешни Shell командиМрежи:основниималкопо-задълбоченипознания–адресиране(IP),маски,шлюзове,протоколи (HTTP\\/HTTPS), Telnet\\/SSH;Работно владеене на някакъв текстообработващ редактор, работещ под Линукс.\r\n', 'След завършване на курса студентите ще могат да:\\\\n1. Създават програми на обектно-ориентиран език java\\\\nв режим на конзолен интерфейс (console language interface – CLI), и\\\\nчрез интегрирана среда за разработка на приложения,\\\\n2. подготовка на документация на проект (чрез javadoc),\\\\n4. входно-изходни операции и форматиране на изхода,\\\\n3. да разработва обектно-ориентирани програми като създава и разпознава конструкциите и принципите от обектно-ориентираното програмиране:\\\\nкласове,\\\\nобекти,\\\\nсвойства, изпращане на съобщения\\\\nметоди за достъп и\\n енкапсулация\\\\n наследяване\\\\n полиморфизъм\\\\n интерфейси\\\\nабстрактни класове\\\\n интерфейси\\\\nсъздаване на графичен потребителски интерфейс и\\\\nпрограмиране, базирано на събития.\\\\nПознаване на структурата и характеристиките на Java технологиите.\\\\nмогат да създават изключения - потребителски и вътрешни и обработката на изключения и грешки.\\\\nДа познават последните промени в Java технологиите и съответно езикът за програмиране Java.\\\\nКурсът включва и теми за напреднали като:\\\\nобработка на символни низове и регулярни изрази,\\\\nрефлекция,\\\\nсериализация на данни и интернационализация на приложения.\\\\nЩе се разгледат множество практически примери на обектно ориентирани програми,\\\\nкато внимание ще се обърне върху създаването на добър стил за програмиране и форматиране на създадените програми.\\\\nЩе се разгледат разликите с други езици за програмиране – както такива, базирани на виртуална машина – като например .Net езиците като C Sharp, така и с процедурни езици като C и обектно-ориентирани езици, които не са базирани на виртуална машина като C++.\\\\nЩе се обърне и внимание на преработка на съществуващи програми (refactoring) и върху основи на софтуерното инженерство в ООП – като софтуерен дизайн и обратно-инженерство (reverse engineering).\\\\nВ курса ще се ползват последна версия на Java (към момента това е JDK 7) и последна версия на интегрирана среда за разработка (например към момента NetBeans 7.2.1+ или Eclipse 4+).\r\n', '[\"Въведение в курса\", \"Java технологии - виртуална машина, език и библиотеки. Реализация и видове проекти\", \"Въведение в ООП. История на ООП езиците за програмиране. Съвременни обектно-ориентирани езици за програмиране, базирани на вирутална машина. Логическа и физическа организация на програмен код. Пакети и компоненти.\", \"Преговор на основните концепции в програмирането в ИКТ\", \"Класове и обкети - конструктори (по подразбиране, без параметри, за общо ползване и за копиране). методи за достъп, полета и област на видимост.\", \"Наследяване - концепции и видове достъп. Примери.\", \"Абстрактни класове. \", \"Интерфейси. Програмиране с контракти.\", \"Статични характеристики на класовете - статични методи, полета и класове.\", \"Грешки и изключения - концепции. Вградени и потребителски дефинирани изключения.\", \"Събитийно-ориентирано програмиране. Изпращане и получаване на съобщения. Работа с графични потребителски интерфейси. Видове графични интерфейси.\", \"Моделиране на класове в Java - концепции и означения. Анализ на съществуващи класове.\", \"Вход\\/изход и работа с файлове - текстови и двоични. Форматиране на данните.\", \"Съвременно състояние на ООП и Java технологиите (разширения на езика)\", \"Сериализируемост и сериализация на данни.\", \"Регулярни изрази\", \"Анотации и рефлекция\", \"Обектни изброими типове (enum). Динамично зареждане на обекти.\"]\r\n', '[\"Класове и обекти 1 – основни принципи. Видове конструктори\", \"Класове и обекти 2 – методи за достъп. Скриване на състояние и поведение (енкапсулация)\", \"Класове и обекти 3 – видове методи в класовете. Връзка между класовете. Метод toString.\", \"Логическа и физическа организация на програмен код.\", \"Стил за писане на качествени програми.\", \"Наследяване. Примери.\", \"Абстрактни класове – особенности и начин на употреба.\", \"Интерфейси – дефиниране и имплементация.\", \"Статични характеристики методи и класове – понятия и приложения.\", \"Изключения и грешки – обработка. Дефиниране и употреба на потребителски изключения. Изключения по време на изпълнение (RuntimeException) и изключения за прихващане (Exception).\", \"Моделиране на класове – означения и приложение.\", \"Събития – дефиниране и обработка. Основи на графичен потребителски интерфейс. Класове с видима рамка (JFrame) и класове контейнери (JPanel).\", \"Преобразуване и форматиране на данни (. Автоматично и потребителско преобразуване.\", \"Съвременно състояние на езика Java (изключения с ресурси, подобрено прихващане на изключения, switch със символен аргумент, двоични литерали, оператор <> (diamond)).\", \"Механизъм на сериализация. Примери.\", \"Работа с регулярни изрази. Практически приложения.\", \"Анотации – дефиниране и обработка. Механизъм на работа.\"]\r\n', '[\"[1] М. Петров, Обектно-ориентирано програмиране (Java), Университетско издателство на Софийски университет „Св. Климент Охридски“, 2013\", \"[2] Oracle Corp., Learning the Java Language\\nOracle Corp., The Java Tutorials, http:\\/\\/docs.oracle.com\\/javase\\/tutorial\\/, последно посетена на 2013-01-05\"]\r\n', 'ООП123', '{\r\n \"Утвърдена с решение на ФС с протокол\": \"№ 13 от 17.12.2018\",\r\n \"Утвърдил\": \"Декан на ФМИ\"\r\n }');

INSERT INTO `curriculums` (`id`, `oks`, `specialty`, `academicYear`) VALUES (NULL, 'Бакалавър', 'Информационни системи', '2018/2019'), (NULL, 'Бакалавър', 'Информационни системи', '2019/2020'), (NULL, 'Бакалавър', 'Информатика', '2018/2019'), (NULL, 'Бакалавър', 'Информатика', '2019/2020'), (NULL, 'Бакалавър', 'Mатематика и информатика', '2019/2020'), (NULL, 'Бакалавър', 'Mатематика и информатика', '2018/2019');

INSERT INTO `curriculum_disciplines` (`curriculumId`, `disciplineId`) VALUES (1, 2), (3, 2), (5, 2),(7, 2), (9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2);

INSERT INTO `depends_on` (`disciplineId`, `code`) VALUES ('2', 'ОСПР123');

INSERT INTO `depend_by` (`disciplineId`, `code`) VALUES ('2', 'AWS123');

INSERT INTO `disciplines` (`id`, `disciplineNameBg`, `disciplineNameEng`, `specialtiesAndCourses`, `category`, `oks`, `professor`, `semester`, `elective`, `credits`, `annotation`, `prerequisites`, `expectations`, `content`, `synopsis`, `bibliography`, `code`, `administrativeInfo`) VALUES (NULL, 'Приложно-програмни интерфейси за работа с облачни архитектури с Амазон Уеб Услуги (AWS)', 'Application programming interfaces for Cloud Architectures with AWS', '[{\r\n \"Софтуерно инженерство\": [\"1\", \"2\", \"3\"],\r\n \"Компютърни науки\": [\"1\", \"2\", \"3\"]\r\n }]', 'ОКН', '[\"Бакалавър\"]', 'доц. д-р Милен Йорданов Петров', 'Летен', 'Избираема', '5', 'Дисциплината адресира необходимото ниво знанияна за създаване на архитектурни решения с уеб услуги на Амазон (AWS).Предвидено е постепенно представяне на информацията и постепенно надграждане на знанията.Дисциплината въвежда някои от най-често използваните услуги на Амазон Уеб Услугииприложно-програмните интерфейси свързани с тях–теория и практически примери.Разглеждат се и различни аспекти от сигурността при разработване и използване на AWS.', 'Операционни системи: Линукс, основни познания за вътрешни Shell команди Мрежи: основни и малко по-задълбочени познания–адресиране(IP), маски, шлюзове, протоколи (HTTP/HTTPS), Telnet/SSH; Работно владеене на някакъв тексто обработващ редактор, работещ под Линукс', 'След завършване на курса студентите ще могат да:\\\\n1. Разграничават различните облачни архитектури;\\\\n2.Ще могат да описват основните Амазон AWS услуги и приложно програмни интерфейси;\\\\n3.Ще имат разбирането и знанията за внимателно използване на ресурсите в облачните инфраструктури;\\\\n4.Да създават API обръщения–през CLI команди и през някои от съществуващите SDK-та на Амазон;\\\\n5. Ще могат свободно за използват Уеб конзолата на Амазон за AWS.\\\\n6. Ще могат да създават основни AWS архитектури;\\\\n7.Ще получат необходимата основа отговаряща на знанията в сертификационния изпит на Амазон „AWS Certified Solution Architect – Associate”', '[\"Основни концепции: - Мрежи (DNS, IP адреси, маскиране); - Сигурност; - Операционни системи (Линукс);\",\r\n \"Основи на Амазон AWS: - Региони; AZs; Крайни Локации; Акаунти; ARNs; Тагове; - Конзола, CLI, APIs Амазон Виртуално Частно Облачно Пространство (VPC); Амазон Еластично Компютърно Пространство(EC2)и Амазон Еластично Блоково Пространство (EBS):-Типове виртуални машини; достъп; Имиджи(AMIs); бекъпи; - част1\",\r\n \"Амазон Виртуално Частно Облачно Пространство (VPC);\\\\nАмазон Еластично Компютърно Пространство (EC2) и Амазон\\\\nЕластично Блоково Пространство (EBS):- Типове виртуални машини; достъп; Имиджи (AMIs); бекъпи; - част1\",\r\n \"Системен Мениджър:\\\\n- Документи;\\\\n- Място за съхранение на параметри;\",\r\n \"Амазон Услуга за Лесно Съхранение (Амазон S3) и Амазон Услуга\\\\nза Продължително Съхранение (Glacier) - част 1\",\r\n \"Амазон Услуга за Лесно Съхранение (Амазон S3) и Амазон Услуга за Продължително Съхранение (Glacier) - част 2\",\r\n \"Амазон Ламбда\",\r\n \"Сигурност в Амазон Уеб Услуги (AWS):\\\\n- Амазон Услуга Охрана (GuardDuty);\\\\n- Амазон Инспектор (Inspector);\",\r\n \"Амазон Услуга за Еластично Балансиране\",\r\n \"Амазон Услуга за Наблюдение на Облачното Пространство (Cloud Watch)\",\r\n \"Автоматично Скалиране (Auto Scaling)\",\r\n \"AWS Услуга за Управление на Идентифицирането и на Достъпа(Identity and Access Management)\",\r\n \"Бази Данни; Амазон Услуга “Обикновена Опашка“ (Amazon Simple Queue Service) и Амазон Услуга за „Обикновено Известяване“ (Amazon Simple notification Service)\",\r\n \"Амазон Услуги: DNS и Route 53; Амазон Услуги за Съхранение на Ключове;\"\r\n ]', '[\r\n \"Област 1: Дизайн на Еластични Архитектури\\\\n1.1. Избор на механизми за надеждно/еластично съхранение.\\\\n1.2. Дизайн на решения с многослойни архитектури.\\\\n1.3. Дизайн на високо надеждни и/или устойчиви на грешки архитектури.\\\\n \",\r\n \"Област 3: Определяне на Сигурни Приложения и Архитектури\\\\n3.1 Определяне на стратегии при защита на приложните слоеве.\\\\n3.2 Определяне на стратегии при защита на данните.\\\\n3.3 Определяне на мрежова инфраструктура за приложения в дадено Виртуално Частно\\\\nОблачно Пространство (VPC). \",\r\n \"Област 4: Дизайн на Оптимизирани по Отношение на Разходите Архитектури\\\\n4.1 Дизайн на място за съхранение на данни, оптимизирано по отношение на разходите.\\\\n4.2 Дизайн на изчислителни ресурси, оптимизирани по отношение на разходите.\",\r\n \"Област 5: Определяне на Архитектури, Готови за Експлоатация\\\\n5.1 Избор на характеристики при дизайн на решения и свързаните с тях приложнопрограмни интерфейси, които дават възможност за оперативни постижения.\"\r\n ]', '[\r\n \"[1.] AWS Certified Solutions Architect - Official Study Guide, Joe Baron, Hisham Baz, TimBixler, Biff Gaut, Kevin E. Kelly, Sean Senior, John Stamper; 2017, John Wiley & Sons\",\r\n \"[2.] Architecting for the Cloud - AWS Best Practices (October 2018) https://d1.awsstatic.com/whitepapers/AWS_Cloud_Best_Practices.pdf \",\r\n \"[3.] AWS Security Best Practices (August 2016) https://d1.awsstatic.com/whitepapers/Security/AWS_Security_Best_Practices.pdf\",\r\n \"[4.] Security Pillar - AWS Well-Architected Framework (July 2018) https://d1.awsstatic.com/whitepapers/architecture/AWS-Security-Pillar.pdf \",\r\n \"[5.]Serverless Architectures with AWS Lambda - Overview and Best Practices(November2017)https://d1.awsstatic.com/whitepapers/serverless-architectures-with-aws-lambda.pdf\",\r\n \"[6.] AWS Documentation - Guides and API References https://docs.aws.amazon.com/index.html#lang/en_us\"\r\n ]', 'AWS123', '\"Административна информация\": {\r\n \"Утвърдена с решение на ФС с протокол\": \"№ 13 от 17.12.2019\",\r\n \"Утвърдил\": \"Декан на ФМИ\"\r\n }'); 

INSERT INTO `curriculum_disciplines` (`curriculumId`, `disciplineId`) VALUES (1, 3), (3, 3), (5, 3),(7, 3);

INSERT INTO `depends_on` (`disciplineId`, `code`) VALUES ('3', 'ОСПР123');

