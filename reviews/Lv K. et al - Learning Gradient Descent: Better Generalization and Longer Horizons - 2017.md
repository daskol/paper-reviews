# Learning Gradient Descent: Better Generalization and Longer Horizons

***Lv K. et al, 2017***

В статье модифицирется метод оптимизации DMoptimizer предложенный в работе Andrychowicz et al., 2016, основанный на рекуррентной нейронной сети.
Общая идея заключается в том, чтобы натренировать некоторую нейросетку на простой модели подстраивать градиенты так, чтобы находить минимум функции потерь.
К сожалению, исходный метод обладает двумя недостатками связаными с обобщающей способностью(ломается при измениии нельнейностей) и неустойчивостью при больших итерациях.
Авторы предлагают делать несколько трюков, которые позволяет не переобучаться, случайно масшабируя аргумент оптимизируемой функции, а также накладывают требование "масштабной инвариантности" на градиенты.
Последние очень существеное требование, авторы мотивируют его на примере state-of-the-art методов. В Adam момент $m_t$ входит в комбинации $m_t / v_t$, то есть как-то масштабируется исходя из прошлых значений градиента.
Эти два основных улучшения как раз и позволяют методу RNNprop, предложенному авторами, показывать результаты сопоставимые с Adam.

Модель RNNprop, как понятно из названия, представляет из себя рекуррентную сеть из двух LSTM-ячеек.
На вход покоординатно подаются моменты и градиенты, которые пропускаются через полносвязный слой.
На выходе градиенты поэлементно обрезаются согласно $\alpha \cdot \tanh(x)$.

Модель тренировалась MLP с 20 скрытыми нейронами методом BPTT. Выполнялось 5 эпизодов по 20 шагов, в сумме 100 шагов.
К знаменателю на входе добавляется маленькое число, чтобы избежать переполнения.
Параметры и начальные значения инициализируются либо из нормального распределения, либо и равноменого.

Такая модель работает сравнимо со state-of-the-art методами или даже лучше на MLP и CNN сетях с различными функциями активации, числом слоём и структурой.
Жаль, что в статье не приводятся результаты работы оптимизатора во времени, а не итерациях.