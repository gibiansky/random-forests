import java.util.*;

class DecisionTree {
    public DecisionTree(Dataset data) {
	
    }

    private DecisionNode learn(Dataset data, int[] attributes,
			       int[] examples) {
	if (examples.length < data.size / 25 ||
	    attributes.length == 0) {
	    return new DecisionLeaf(plurality(data, examples));
	} else {
	    // Iterate over attributes. For each one, compute its attribute
	    // pair, choosing the best threshold for that attribute. Then
	    // select the best attribute via information gain and use that
	    // to make a decision fork.
	}
    }

    private String plurality(Dataset data, int[] examples) {
	HashMap<String, Integer> map = new HashMap<String, Integer>();
	for (int example : examples ) {
	    String label = data.labels[example];
	    if (map.containsKey(label)) {
		map.put(label, map.get(label)+1);
	    } else {
		map.put(label, 1);
	    }
	}
	String plurality;
	int maxCount = -1;
	for (String label : map.keySet()) {
	    if (map.get(label) > maxCount) {
		maxCount = map.get(label);
		plurality = label;
	    }
	}
	return plurality;
    }

    private abstract class DecisionNode {
	public abstract String classify(double[]);
    }

    private class DecisionFork extends DecisionNode {
	public int attribute;
	public double threshold;
	public DecisionNode left, right;

	public DecisionFork(int attribute, double threshold,
			    DecisionFork left, DecisionFork right) {
	    this.attribute = attribute;
	    this.threshold = threshold;
	    this.left = left;
	    this.right = right;
	}

	public String classify(double[] attributeValues) {
	    if (attributeValues[this.attribute] < this.threshold) {
		return this.left.classify(attributeValues);
	    } else {
		return this.right.classify(attributeValues);
	    }
	}
    }

    private class DecisionLeaf extends DecisionNode {
	public String label;

	public DecisionLeaf(String label) {
	    this.label = label;
	}

	public String classify(double[] attributeValues) {
	    return this.label;
	}
    }

    private class AttributePair {
	public double threshold;
	public double informationGain;
    }
}