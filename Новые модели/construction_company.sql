-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 08 2026 г., 13:48
-- Версия сервера: 5.6.51
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `construction_company`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Estimate`
--

CREATE TABLE `Estimate` (
  `estimate_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Estimate`
--

INSERT INTO `Estimate` (`estimate_id`, `order_id`, `total_amount`, `created_at`) VALUES
(1, 1, '40500.00', '2026-05-05 10:39:56'),
(2, 9, '60500.00', '2026-05-05 10:39:56'),
(3, 2, '144000.00', '2026-05-05 10:39:56'),
(4, 3, '36000.00', '2026-05-05 10:39:56'),
(5, 4, '165750.00', '2026-05-05 10:39:56'),
(6, 8, '36000.00', '2026-05-05 10:39:56'),
(7, 5, '60000.00', '2026-05-05 10:39:56'),
(8, 10, '20400.00', '2026-05-05 10:39:56'),
(9, 6, '30000.00', '2026-05-05 10:39:56'),
(10, 7, '23400.00', '2026-05-05 10:39:56');

-- --------------------------------------------------------

--
-- Структура таблицы `EstimateItem`
--

CREATE TABLE `EstimateItem` (
  `estimate_item_id` int(11) NOT NULL,
  `estimate_id` int(11) NOT NULL,
  `price_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `price_at_moment` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `EstimateItem`
--

INSERT INTO `EstimateItem` (`estimate_item_id`, `estimate_id`, `price_id`, `quantity`, `price_at_moment`, `total`) VALUES
(1, 1, 1, '45.00', '300.00', '13500.00'),
(2, 3, 3, '120.00', '400.00', '48000.00'),
(3, 4, 2, '80.00', '150.00', '12000.00'),
(4, 5, 1, '65.00', '300.00', '19500.00'),
(5, 5, 2, '65.00', '150.00', '9750.00'),
(6, 5, 3, '65.00', '400.00', '26000.00'),
(7, 1, 1, '45.00', '300.00', '13500.00'),
(8, 3, 3, '120.00', '400.00', '48000.00'),
(9, 4, 2, '80.00', '150.00', '12000.00'),
(10, 5, 1, '65.00', '300.00', '19500.00'),
(11, 5, 2, '65.00', '150.00', '9750.00'),
(12, 5, 3, '65.00', '400.00', '26000.00'),
(13, 1, 1, '45.00', '300.00', '13500.00'),
(14, 3, 3, '120.00', '400.00', '48000.00'),
(15, 4, 2, '80.00', '150.00', '12000.00'),
(16, 5, 1, '65.00', '300.00', '19500.00'),
(17, 5, 2, '65.00', '150.00', '9750.00'),
(18, 5, 3, '65.00', '400.00', '26000.00'),
(19, 7, 3, '150.00', '400.00', '60000.00'),
(20, 9, 2, '200.00', '150.00', '30000.00'),
(21, 10, 1, '52.00', '300.00', '15600.00'),
(22, 10, 2, '52.00', '150.00', '7800.00'),
(24, 6, 3, '90.00', '400.00', '36000.00'),
(25, 2, 2, '110.00', '150.00', '16500.00'),
(26, 2, 3, '110.00', '400.00', '44000.00'),
(28, 8, 1, '68.00', '300.00', '20400.00');

--
-- Триггеры `EstimateItem`
--
DELIMITER $$
CREATE TRIGGER `trg_estimateitem_before_insert` BEFORE INSERT ON `EstimateItem` FOR EACH ROW BEGIN
    SET NEW.total = NEW.quantity * NEW.price_at_moment;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_estimateitem_before_update` BEFORE UPDATE ON `EstimateItem` FOR EACH ROW BEGIN
    IF NEW.quantity <> OLD.quantity OR NEW.price_at_moment <> OLD.price_at_moment THEN
        SET NEW.total = NEW.quantity * NEW.price_at_moment;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Manager`
--

CREATE TABLE `Manager` (
  `manager_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Manager`
--

INSERT INTO `Manager` (`manager_id`, `name`, `role`, `email`, `phone`, `created_at`) VALUES
(1, 'Ирина Менеджер', 'Ведущий менеджер', 'irina@company.com', NULL, '2026-05-05 10:39:26'),
(2, 'Петр Администратор', 'Менеджер по работе с клиентами', 'petr@company.com', NULL, '2026-05-05 10:39:26');

-- --------------------------------------------------------

--
-- Структура таблицы `Notification`
--

CREATE TABLE `Notification` (
  `notify_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `type` enum('email','sms') NOT NULL,
  `recipient` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `status` enum('pending','sent','failed') DEFAULT 'pending',
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Notification`
--

INSERT INTO `Notification` (`notify_id`, `order_id`, `type`, `recipient`, `message`, `status`, `sent_at`, `created_at`) VALUES
(1, 1, 'email', 'guest1@temp.com', 'Уважаемый клиент! Ваш заказ №1 зарегистрирован. Смета: 40500.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(2, 9, 'email', 'guest9@temp.com', 'Уважаемый клиент! Ваш заказ №9 зарегистрирован. Смета: 60500.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(3, 2, 'email', 'guest2@temp.com', 'Уважаемый клиент! Ваш заказ №2 зарегистрирован. Смета: 144000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(4, 3, 'email', 'guest3@temp.com', 'Уважаемый клиент! Ваш заказ №3 зарегистрирован. Смета: 36000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(5, 7, 'email', 'andrey@example.com', 'Уважаемый клиент! Ваш заказ №7 зарегистрирован. Смета: 23400.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(6, 5, 'email', 'dima@example.com', 'Уважаемый клиент! Ваш заказ №5 зарегистрирован. Смета: 60000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(7, 10, 'email', 'dima@example.com', 'Уважаемый клиент! Ваш заказ №10 зарегистрирован. Смета: 20400.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(8, 4, 'email', 'maria@example.com', 'Уважаемый клиент! Ваш заказ №4 зарегистрирован. Смета: 165750.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(9, 8, 'email', 'maria@example.com', 'Уважаемый клиент! Ваш заказ №8 зарегистрирован. Смета: 36000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(10, 6, 'email', 'olga@example.com', 'Уважаемый клиент! Ваш заказ №6 зарегистрирован. Смета: 30000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(16, 1, 'sms', '+70000000000', 'Заказ №1 принят. Сумма: 40500.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(17, 9, 'sms', '+70000000000', 'Заказ №9 принят. Сумма: 60500.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(18, 2, 'sms', '+70000000000', 'Заказ №2 принят. Сумма: 144000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(19, 3, 'sms', '+70000000000', 'Заказ №3 принят. Сумма: 36000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(20, 4, 'sms', '+79161234567', 'Заказ №4 принят. Сумма: 165750.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(21, 8, 'sms', '+79161234567', 'Заказ №8 принят. Сумма: 36000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(22, 5, 'sms', '+79162223344', 'Заказ №5 принят. Сумма: 60000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(23, 10, 'sms', '+79162223344', 'Заказ №10 принят. Сумма: 20400.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(24, 6, 'sms', '+79163334455', 'Заказ №6 принят. Сумма: 30000.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53'),
(25, 7, 'sms', '+79164445566', 'Заказ №7 принят. Сумма: 23400.00 руб.', 'sent', '2026-05-05 10:41:53', '2026-05-05 10:41:53');

-- --------------------------------------------------------

--
-- Структура таблицы `Order`
--

CREATE TABLE `Order` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `object_type` varchar(50) NOT NULL,
  `work_type` text NOT NULL,
  `area` decimal(10,2) NOT NULL,
  `deadline` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'new',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Order`
--

INSERT INTO `Order` (`order_id`, `user_id`, `manager_id`, `object_type`, `work_type`, `area`, `deadline`, `status`, `created_at`) VALUES
(1, 1, 1, 'Квартира', 'Штукатурка, укладка ламината', '45.00', '2025-06-15', 'new', '2026-05-05 10:39:47'),
(2, 2, 2, 'Дом', 'Демонтаж, стяжка пола', '120.00', '2025-07-01', 'in_progress', '2026-05-05 10:39:47'),
(3, 3, NULL, 'Офис', 'Покраска стен, электрика', '80.00', '2025-08-10', 'new', '2026-05-05 10:39:47'),
(4, 4, 1, 'Квартира', 'Стяжка пола, укладка ламината, покраска', '65.00', '2025-09-01', 'new', '2026-05-05 10:39:47'),
(5, 5, 2, 'Дом', 'Штукатурка, стяжка пола, электрика', '150.00', '2025-10-20', 'in_progress', '2026-05-05 10:39:47'),
(6, 6, 1, 'Коттедж', 'Демонтаж, штукатурка, покраска', '200.00', '2025-11-05', 'completed', '2026-05-05 10:39:47'),
(7, 7, NULL, 'Квартира', 'Укладка ламината, покраска', '52.00', '2025-12-12', 'new', '2026-05-05 10:39:47'),
(8, 4, 2, 'Офис', 'Стяжка пола, электрика, штукатурка', '90.00', '2026-01-15', 'new', '2026-05-05 10:39:47'),
(9, 1, 2, 'Дом', 'Демонтаж, стяжка пола, покраска', '110.00', '2026-02-20', 'new', '2026-05-05 10:39:47'),
(10, 5, 1, 'Квартира', 'Электрика, укладка ламината', '68.00', '2026-03-01', 'new', '2026-05-05 10:39:47');

-- --------------------------------------------------------

--
-- Структура таблицы `PriceList`
--

CREATE TABLE `PriceList` (
  `price_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` enum('MATERIAL','LABOR','EQUIPMENT') NOT NULL,
  `unit` varchar(20) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `valid_from` date NOT NULL,
  `valid_to` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `PriceList`
--

INSERT INTO `PriceList` (`price_id`, `name`, `category`, `unit`, `price`, `valid_from`, `valid_to`, `is_active`, `created_at`) VALUES
(1, 'Укладка ламината', 'LABOR', 'м²', '300.00', '2024-01-01', NULL, 1, '2026-05-05 10:36:04'),
(2, 'Покраска стен', 'LABOR', 'м²', '150.00', '2024-01-01', NULL, 1, '2026-05-05 10:36:04'),
(3, 'Стяжка пола', 'LABOR', 'м²', '400.00', '2024-01-01', NULL, 1, '2026-05-05 10:36:04'),
(4, 'Гипсокартон', 'MATERIAL', 'лист', '350.00', '2024-01-01', NULL, 1, '2026-05-05 10:36:04'),
(5, 'Краска водно-дисперсионная', 'MATERIAL', 'л', '250.00', '2024-01-01', NULL, 1, '2026-05-05 10:36:04');

-- --------------------------------------------------------

--
-- Структура таблицы `User`
--

CREATE TABLE `User` (
  `user_id` int(11) NOT NULL,
  `session_id` varchar(191) DEFAULT NULL,
  `cookie_consent` tinyint(1) DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT '1',
  `registered_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `User`
--

INSERT INTO `User` (`user_id`, `session_id`, `cookie_consent`, `name`, `email`, `phone`, `password_hash`, `is_guest`, `registered_at`, `is_active`, `created_at`) VALUES
(1, 'guest_sess_01', 1, 'Гость Анатолий', NULL, NULL, NULL, 1, NULL, 1, '2026-05-05 10:39:02'),
(2, 'guest_sess_02', 1, 'Гость Елена', NULL, NULL, NULL, 1, NULL, 1, '2026-05-05 10:39:02'),
(3, 'guest_sess_03', 1, 'Гость Сергей', NULL, NULL, NULL, 1, NULL, 1, '2026-05-05 10:39:02'),
(4, NULL, 0, 'Мария Соколова', 'maria@example.com', '+79161234567', 'hash_maria', 0, '2026-05-05 10:39:02', 1, '2026-05-05 10:39:02'),
(5, NULL, 0, 'Дмитрий Иванов', 'dima@example.com', '+79162223344', 'hash_dima', 0, '2026-05-05 10:39:02', 1, '2026-05-05 10:39:02'),
(6, NULL, 0, 'Ольга Кузнецова', 'olga@example.com', '+79163334455', 'hash_olga', 0, '2026-05-05 10:39:02', 1, '2026-05-05 10:39:02'),
(7, NULL, 0, 'Андрей Павлов', 'andrey@example.com', '+79164445566', 'hash_andrey', 0, '2026-05-05 10:39:02', 1, '2026-05-05 10:39:02');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `v_active_pricelist`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `v_active_pricelist` (
`price_id` int(11)
,`name` varchar(255)
,`category` enum('MATERIAL','LABOR','EQUIPMENT')
,`unit` varchar(20)
,`price` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `v_estimate_summary`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `v_estimate_summary` (
`estimate_id` int(11)
,`order_id` int(11)
,`total_amount` decimal(12,2)
,`created_at` timestamp
,`items_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `v_order_details`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `v_order_details` (
`order_id` int(11)
,`object_type` varchar(50)
,`area` decimal(10,2)
,`status` varchar(20)
,`created_at` timestamp
,`client_name` varchar(100)
,`client_email` varchar(100)
,`client_phone` varchar(20)
,`manager_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Структура для представления `v_active_pricelist`
--
DROP TABLE IF EXISTS `v_active_pricelist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_active_pricelist`  AS SELECT `pricelist`.`price_id` AS `price_id`, `pricelist`.`name` AS `name`, `pricelist`.`category` AS `category`, `pricelist`.`unit` AS `unit`, `pricelist`.`price` AS `price` FROM `pricelist` WHERE ((`pricelist`.`is_active` = 1) AND (`pricelist`.`valid_from` <= curdate()) AND (isnull(`pricelist`.`valid_to`) OR (`pricelist`.`valid_to` >= curdate())))  ;

-- --------------------------------------------------------

--
-- Структура для представления `v_estimate_summary`
--
DROP TABLE IF EXISTS `v_estimate_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_estimate_summary`  AS SELECT `e`.`estimate_id` AS `estimate_id`, `e`.`order_id` AS `order_id`, `e`.`total_amount` AS `total_amount`, `e`.`created_at` AS `created_at`, count(`ei`.`estimate_item_id`) AS `items_count` FROM (`estimate` `e` left join `estimateitem` `ei` on((`e`.`estimate_id` = `ei`.`estimate_id`))) GROUP BY `e`.`estimate_id``estimate_id`  ;

-- --------------------------------------------------------

--
-- Структура для представления `v_order_details`
--
DROP TABLE IF EXISTS `v_order_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_order_details`  AS SELECT `o`.`order_id` AS `order_id`, `o`.`object_type` AS `object_type`, `o`.`area` AS `area`, `o`.`status` AS `status`, `o`.`created_at` AS `created_at`, `u`.`name` AS `client_name`, `u`.`email` AS `client_email`, `u`.`phone` AS `client_phone`, `m`.`name` AS `manager_name` FROM ((`order` `o` left join `user` `u` on((`o`.`user_id` = `u`.`user_id`))) left join `manager` `m` on((`o`.`manager_id` = `m`.`manager_id`)))  ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Estimate`
--
ALTER TABLE `Estimate`
  ADD PRIMARY KEY (`estimate_id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Индексы таблицы `EstimateItem`
--
ALTER TABLE `EstimateItem`
  ADD PRIMARY KEY (`estimate_item_id`),
  ADD KEY `idx_estimate` (`estimate_id`),
  ADD KEY `idx_price` (`price_id`);

--
-- Индексы таблицы `Manager`
--
ALTER TABLE `Manager`
  ADD PRIMARY KEY (`manager_id`);

--
-- Индексы таблицы `Notification`
--
ALTER TABLE `Notification`
  ADD PRIMARY KEY (`notify_id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_status` (`status`);

--
-- Индексы таблицы `Order`
--
ALTER TABLE `Order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `manager_id` (`manager_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created` (`created_at`);

--
-- Индексы таблицы `PriceList`
--
ALTER TABLE `PriceList`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `idx_category` (`category`,`is_active`),
  ADD KEY `idx_valid_dates` (`valid_from`,`valid_to`);

--
-- Индексы таблицы `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_session` (`session_id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_guest` (`is_guest`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Estimate`
--
ALTER TABLE `Estimate`
  MODIFY `estimate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `EstimateItem`
--
ALTER TABLE `EstimateItem`
  MODIFY `estimate_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT для таблицы `Manager`
--
ALTER TABLE `Manager`
  MODIFY `manager_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Notification`
--
ALTER TABLE `Notification`
  MODIFY `notify_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `Order`
--
ALTER TABLE `Order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `PriceList`
--
ALTER TABLE `PriceList`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Estimate`
--
ALTER TABLE `Estimate`
  ADD CONSTRAINT `estimate_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `EstimateItem`
--
ALTER TABLE `EstimateItem`
  ADD CONSTRAINT `estimateitem_ibfk_1` FOREIGN KEY (`estimate_id`) REFERENCES `Estimate` (`estimate_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `estimateitem_ibfk_2` FOREIGN KEY (`price_id`) REFERENCES `PriceList` (`price_id`);

--
-- Ограничения внешнего ключа таблицы `Notification`
--
ALTER TABLE `Notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Order`
--
ALTER TABLE `Order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `Manager` (`manager_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
