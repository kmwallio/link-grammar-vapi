using LinkGrammar;

namespace Hello {
    public class Hola {
        public static int main (string[] args) {
            print ("# Link Grammar Sample\n");
            string[] input_strings = {
                "He eats cake.",
                "He eat cake.",
                "The side affects were devastating.",
                "The side effects were devastating."
            };

            var opts = new ParseOptions ();
            var dict = new Dictionary.create_lang ("en");

            opts.set_max_null_count (10);

            if (dict == null) {
                warning ("Could not load dictionary");
                return 1;
            }

            for (int i = 0; i < input_strings.length; i++) {
                var sentence = new Sentence (input_strings[i], dict);
                sentence.split (opts);
                var num_linkages = sentence.parse (opts);
                if (num_linkages > 0) {
                    var linkage = new Linkage (0, sentence, opts);
                    var diagram = linkage.print_diagram (true, 800);
                    print ("%s\n", diagram);
                } else {
                    var linkage = new Linkage (0, sentence, opts);
                    print ("%s\n", linkage.print_constituent_tree(ConstituentDisplayStyle.SINGLE_LINE));
                }
            }

            return 0;
        }
    }
}