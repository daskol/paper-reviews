# Glow: Generative flow with invertible 1x1 convolutions

***Kingma et al, 2018***

Единственным значимым результатом статьи является введение обратимой 1x1
свёртки. Конечно же результаты экспериментов авторов превосходят результаты
предшественников. Правда сравниваться приходится с (Dinh, 2014) и (Dinh, 2016),
где и была предложенна модель RealNVP, улучшенная в последствии Дереком Кингма.
Других бенчмарков, которые попались мне на глаза, по сути и нет. Дело в том, что
работа авторов связана с так называемыми normalizing flows, которые появились
сравнительно недавно в работе (Tabak & Turner, 2013). Нормализующие потоки имеют
самостоятельную значимость в контексте генеративных моделей, VAE/GAN в частности
и заслуживают отдельного внимания.

Потоком назывют сложную биективную функцию, которая может быть представленная,
как `f = f_n \cdot \f_{n -1} \cdot ... \cdot f_1`. Фунции `{f_k}` тоже должны
быть обратимыми и достаточно простыми. Первое свойство гарантирует, что можно
найти обратную `g = f^{-1}`, а второе вычислительную несложность. Это может быть
полезно для прямой апроксимации правдоподобия или постериорной вероятности
события без оптимизации нижней границы правдоподобия (ELBO) как в VAE.

Основная цель в построении потока является такой выбор функции, чтобы можно было
достаточно просто вычислитять Якобианы функцию-элемент потока. Авторы замечают,
что в оригинальной моделе RealNVP перестановки каналов в тензоре (изображении)
происходит не оптимально, и можно сделать лучше. Они предлагают рассмотреть 1x1
свёртку. Дело в том, что 1x1 свёртки действую попиксельно только на каналы. Их
действие на тензор (изображение) размера w x h x c эквивалентно умножение на
матрицу весов W размера c x c справа. Матрица должна быть квадратной и не
вырожденной. Якобиан такой свёртки вычислится следующим образом
$$
    |\det \frac{d \mathrm{conv2D}(h; W)}{d h}| = h \cdot w \cdot |\det W|.
$$
Вычиление детерминанта матрицы `W` требует `O(c^3)` операций. На самом деле
вычислять определитель и обратную матрицы можно быстрее. Для этого достаточно
сделать LU-разложении весовой матрицу.
$$
    W = P L (U + diag(s)).
$$
Матрица перестановок `P` не обучается. Нижне-треугольная матрица `L` с единицами на
диагонали, верхнетреугольна матрица `U` с нулями на диагонали и диагональные
элементы `s` напротив обучаются.

Эксперименты проведены качественно. Придраться не к чему. Конкурентным
преимуществом своей работы авторы считают генерацию качественных high-resolution
сэмплов, что является хорошим результатом для моделей, которы напрямую
оптимизируют правдоподобие. Количественные характеристики тоже говорят в пользу
Glow.
