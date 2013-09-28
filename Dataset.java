import java.io.*;
import java.util.*;

public class Dataset {
    public String[] labels;
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

    private void populate(double[][] data, String[] labels) {
        this.data = data;
        this.labels = labels;
        this.numAttributes = this.data[0].length;
        this.size = this.data.length;
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
