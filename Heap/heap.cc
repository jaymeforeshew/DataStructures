#include <iostream>
#include <vector>
#include <math.h>
using namespace std;

class Heap {
	public:
		Heap();
		void insert(int);
		int popMax();
    void printHeap();

	private:
		vector<int> heap;
    int length;
		void swap(int, int);
};

// constructor
Heap::Heap() {
	length = 0;
}

// returns an index's parent index. Parent's index must exist.
// ie. doesn't make sense for index 0.
int getParentIndex(int index) {
  return floor((index-1)/2);
}

int getLeftChildIndex(int index) {
	return 2*index + 1;
}

int getRightChildIndex(int index) {
	return 2*index + 2;
}


// swaps values at these two indexes in the heap
void Heap::swap(int a, int b) {
	int tmp = heap[a];
  heap[a] = heap[b];
	heap[b] = tmp;
	return;
}


// insert element into heap
void Heap::insert(int element) {
	// add an empty element to the end of the vector
  length++;
	heap.resize(length);

	int index = length - 1;
	heap[index] = element;

	int parentIndex;

	while (index > 0) {
		parentIndex = getParentIndex(index);

		// if we need to bubble up, we swap the element at index with the element at parent
    if (heap[index] > heap[parentIndex]) {
			swap(index, parentIndex);
			index = parentIndex;
		} else {
			break;
		}
	}

	return;
}

bool isOutOfBounds(int index, int length) {
	if (index >= length) {
		return true;
	}
	return false;
}

int Heap::popMax() {
	int maximum = heap[0];

	// move the most-recently-entered element to the root
	heap[0] = heap[length-1];
	heap[length-1] = -1;

	// our heap is now 1 element shorter
	length--;
	
  int index = 0;

	while (true) {
		int leftChild = getLeftChildIndex(index);
		int rightChild = getRightChildIndex(index);

		int isLeftOutOfBounds = isOutOfBounds(leftChild, length);
		int isRightOutOfBounds = isOutOfBounds(rightChild, length);

		if (isLeftOutOfBounds) {
			// if left is out of bounds, right is necessarily out of bounds. We found our home.
			break;
    } else if (isRightOutOfBounds) {
			// check if we need to swap leftChild and index
			if (heap[index] < heap[leftChild]) {
				swap(index, leftChild);
				index = leftChild;
				continue;
			}

			// if we don't need to swap, we found our home
			break;
    } else {
			// swap with the larger of the two, if necessary
			if (heap[leftChild] > heap[rightChild]) {
				if (heap[leftChild] > heap[index]) {
					swap(index, leftChild);
					index = leftChild;
					continue;
				}

				break; // if no swap needed, we found our home
			} else {
				if (heap[rightChild] > heap[index]) {
					swap(index, rightChild);
					index = rightChild;
					continue;
				}
				break;
			}
		}
	}

	return maximum;
}

// print out the heap in format (index: element)
void Heap::printHeap() {
	for (int i = 0; i < length; i++) {
		cout << i << ": " << heap[i] << endl;
	}
	return;
}


int main() {

  Heap* heap = new Heap();
	heap->insert(1);
	heap->insert(2);
	heap->insert(3);

	cout << "Starting" << endl;
	heap->printHeap();

	cout << "Add 8, 4, 9" << endl;
	heap->insert(8);
	heap->insert(4);
	heap->insert(9);
	heap->printHeap();

	cout << "POP MAX: " << heap->popMax() << endl;
  heap->printHeap();

	cout << "POP MAX: " << heap->popMax() << endl;
  heap->printHeap();

	cout << "POP MAX: " << heap->popMax() << endl;
  heap->printHeap();
	
	return 0;
}
