# Sorting in Eiffel
Structures that implement [INDEXABLE](https://www.eiffel.org/files/doc/static/20.05/libraries/base/indexable_chart.html) interface can be sorted using the library [base_extension](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/index.html).
This library provides an interface [SORTER](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/sorter_chart.html) and a few implementations of known sorting algorithms like [Bubble sort](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/bubble_sorter_chart.html), [Quick sort](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/quick_sorter_chart.html), [Shell sort](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/shell_sorter_chart.html).

To use one of this algorithms you will need to implement a comparator.
You can use a partial order comparator defined in the interface [PART_COMPARATOR](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/part_comparator_chart.html) or a total order comparator defined in the interface [COMPARATOR]https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/comparator_chart.html


## Using an existing implementation
This example uses the [AGENT_EQUALITY_TESTER](https://www.eiffel.org/files/doc/static/20.05/libraries/base_extension/part_comparator_chart.html)  implementaiton of [PART_COMPARATOR] using agents.


```
sort_array (array: INDEXABLE [INTEGER, INTEGER])
	    local
	        l_sorter: SORTER [INTEGER]
	    do
	        create {QUICK_SORTER [INTEGER]} l_sorter.make (
	        (create {AGENT_EQUALITY_TESTER [INTEGER]}.make (
                agent (a_int1, a_int2: INTEGER): BOOLEAN
                    do
                        Result := a_int1 < a_int2
                    end))
	        )
	        l_sorter.sort (array)
	    end
```

## Implement your own comparator
To implement our own comparator, just inherit from `PART_COMPARATOR` and implement the `less_than` feature

```
class
	PERSON_COMPARATOR

inherit

	PART_COMPARATOR [PERSON]

feature

	less_than (u, v: PERSON): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := u.name < v.name
		end
end
```

## Using our comparator

```
sort_array_person (array: INDEXABLE [PERSON, INTEGER])
    local
        l_sorter: SORTER [PERSON]
    do
        create {QUICK_SORTER [PERSON]} l_sorter.make (create {PERSON_COMPARATOR})
        l_sorter.sort (array)
    end
```
