package forests;

import java.io.*;
import java.util.*;


public class Dataset {
    public String[] labels;
    public String[] classes;
    public double[][] data;
    public int numAttributes;
    public int size;

    public Dataset(String filename) throws IOException {
        String[] lines = Dataset.getContents(filename);
        int numAttributes = lines[0].split(",").length - 1;

        double[][] data = new double[lines.length][numAttributes];
        String[] classes = new String[lines.length];
        for (int i = 0; i < lines.length; i++) {
            String[] pieces = lines[i].split(",");
            for(int j = 0; j < pieces.length - 1; j++){
                data[i][j] = Double.valueOf(pieces[j]);
            }

            classes[i] = pieces[pieces.length - 1].trim();
        }

        populate(data, classes);
    }

    public Dataset(double[][] data, String[] labels) {
        populate(data, labels);
    }

    public Dataset[] split(double[] proportions) {
        Dataset[] outputs = new Dataset[proportions.length];

        double cumulative = 0;
        for (int i = 0; i < proportions.length; i++) {
            int start = ((int) cumulative * this.size);
            int end = (int) ((cumulative + proportions[i]) * this.size);

            double[][] data = new double[end - start][this.numAttributes];
            String[] labels = new String[end - start];
            for (int j = 0; j < end - start; j++) {
                data[j] = this.data[start + j];
                labels[j] = this.labels[start + j];
            }
            
            outputs[i] = new Dataset(data, labels);

            cumulative += proportions[i];
        }

        return outputs;
    }

    private void populate(double[][] data, String[] labels) {
        // Generate indices and shuffle them.
        ArrayList<Integer> indices = new ArrayList<Integer>();
        for (int i = 0; i < labels.length; i++) {
            indices.add(i);
        }
        Collections.shuffle(indices);

        double[][] shuffledData = new double[data.length][this.numAttributes];
        String[] shuffledLabels = new String[labels.length];
        for (int i = 0; i < indices.size(); i++) {
            shuffledData[i] = data[indices.get(i)];
            shuffledLabels[i] = labels[indices.get(i)];
        }

        this.data = shuffledData;
        this.labels = shuffledLabels;
        this.numAttributes = this.data[0].length;
        this.size = this.data.length;

        HashSet<String> classes = new HashSet<String>();
        for (String label : this.labels) {
            classes.add(label);
        }
        this.classes = new String[classes.size()];
        int i = 0;
        for (String cls : classes) {
            this.classes[i] = cls;
            i++;
        }
    }


    public Dataset bootstrap(int n) {
        double[][] bootstrappedData = new double[n][this.numAttributes];
        String[] bootstrappedLabels = new String[n];

        for (int i = 0; i < n; i++) {
            int index = chooseRandomElement(); 
            bootstrappedData[i] = this.data[index];
            bootstrappedLabels[i] = this.labels[index];
        }

        return new Dataset(bootstrappedData, bootstrappedLabels);
    }

    public String toString() {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < this.size; i++) {
            for (int j = 0; j < this.numAttributes; j++) {
                builder.append(String.format("%.2f,", this.data[i][j]));
            }
            builder.append(this.labels[i]);
            builder.append("\n");
        }

        return builder.toString();
    }

    private int chooseRandomElement() {
        return (int) (Math.random() * this.labels.length);
    } 

    private static String[] getContents(String filename) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        ArrayList<String> lines = new ArrayList<String>();

        String nextLine = reader.readLine();
        while(nextLine != null){
            if(nextLine.trim().length() > 0)
                lines.add(nextLine);

            nextLine = reader.readLine();
        }

        return lines.toArray(new String[lines.size()]);
    }
}
