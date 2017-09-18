# Quantum Random Access Memory(qRAM)

***Giovannetti et al***

Также как оперативаная память произвольного доступа является важной частью
классического компьютера, её квантовый аналог столь же важен и для квантового
компьютера. Более того, квантовая память является необходимым элементом для
реализации алгоритмов поиска или поиска коллизий.  Квантовая память &mdash; это
устройство, которое по состоянию адресного регистра возвращает состояние этого
же регистра, запутанное с регистром данных.

### Классическая память

Классическая память в представляет из себя массив ячеек, над которыми
расположена структура бинарного дерева. Путь до каждого листа такого дерева
можно закодировать с помощью ноликов и единичек. Глубина дерева равна числу
бит.  Когда мы спускаемся по такому дереву, то выбираем ребёнка текущего узла.
Ребёнок же определяется, исходя из значения триггера в этом узле, состояние
которого в свою очередь определяется соответствующем значением бита.
Классическая память устроена таким образом, что все триггеры на одной глубине
переключены в одно и то же состояние. Другими словами, один бит активирует
экспотенциальное число триггеров.

(Насколько я помню из курса цифровой электронники, память всё-таки устроена
принципиально сложнее, чем это описано в статье, и оценки здесь несправедливы.)

### Квантовое обобщенеи классической памяти

Прямое обобщение классической схемы приводит к следующему. Адресные `n` кубитов
когерентно контролируют `n` переключающих линий(триггеров, расположенных на
одной глубине). Таким образом, двоичный адрес оказывается скореелирован с
множеством переключателей, выделяющий определённый путь до нужной ячейки с
данными.

Затем шине данных позволяется взаимодействовать с корня получившегося графа, в
результате чего возникает суперпозиция состояний шины и регистра данных.

Последний этап -- распутывания шины и регистра -- заключается в перемещении
шины по пути в графе в обратном направлении(применение обратного
преобразования).

В такой моделе памяти адресные кубиты взаимодействую с `O(N)` вентилями, что
требует хороших корректирующих кодов, и приводит к разрушению состояния.

### Квантовая память

Можно поступить экономичнее. Для этого вводится трит(имеет три состояния),
который помещается в каждый узел двоичного дерева. Третье состояние, кодирует
простое ожидание. Теперь, действие адресного бита выводит переключатели из
промежуточного состояние в какое-то определённое(лево или право).  Таким
образом цепочка адресных бит переключает только те триты, которые расположены
на пути от корня к листьям.

Далее, по той же схеме вносится шина данных по полученому пути и обратно, чтобы
распутать запутанное с переключателями состояние. Соответственно, лишь
логорифмическое число вентилей по числу ячеек памяти оказывается запутанным,
что приводит к большей добротности системы и меньшей декогеренции. Есть нюанс
связанный с использованием кубитов с тремя состояниями.

### Схема физической реализации

Такая модель памяти может быть реализована, например, на оптических массивах,
джозефосоновских элементах или квантовых точках. В качестви кутритов можно
использовать ионы в ловушках со спектром вырожденный по спину. В таком случае
возбуждать атом можнно фотонами различной поляризации. После того, как адресный
фотоны были высвечены на граф, по нему пропускается фотон шины, который доходит
до конца листа и изменяет свою поляризацию в соответствии с состоянием ячейки
памяти, а затем отражается обратно. Адресные фотоны высвечиваются, и остаётся
фотон шины, запутанный с ячейкой памяти.