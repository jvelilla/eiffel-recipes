# Sorting in Eiffel
Structures that implement [INDEXABLE](https://www.eiffel.org/files/doc/static/20.05/libraries/base/indexable_chart.html) interface can be sorted using the library base_extension.
This library provides an interface [SORTER](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/sorter_chart.html) and a few implementations of known sorting algorithms like Bubble-sort, Quick-Sort, Shell Sort.

To use one of this algorithms you will need to implement a partial order comparator defined in the interface [PART_COMPARATOR](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/part_comparator_chart.html), or use the AGENT_EQUALITY_TESTER [G].



