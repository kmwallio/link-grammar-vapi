# My First Time VAPI...

your milage may vary. A Vala Binding for [link-grammar](https://github.com/opencog/link-grammar/).

## Requirements

```
liblink-grammar-dev
```

### Usage:

Put linkgrammar.vapi in your vapi directory.

```meson
add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')

# Find linkgrammar
linkgrammar = dependency('liblink-grammar', version: '>= 5.8.0', required: false)
if linkgrammar.found() == false
    cc = meson.get_compiler('c')
    linkgrammar = cc.find_library('liblink-grammar', required: true)
endif
```

### Usage

```vala
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
            var dict = new Dictionary ("en");

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
```

#### Sample Output

```
# Link Grammar Sample
link-grammar: Info: Dictionary found at /usr/share/link-grammar/en/4.0.dict

    +-----------Xp-----------+
    +---->WV--->+            |
    +->Wd--+-Ss-+---Ou--+    +--RW--+
    |      |    |       |    |      |
LEFT-WALL he eats.v cake.n-u . RIGHT-WALL



    +------------Xp-----------+
    +---->Wi-----+---Ou--+    +--RW--+
    |            |       |    |      |
LEFT-WALL [he] eat.v cake.n-u . RIGHT-WALL



    +-----------------------Xp----------------------+
    +-------->WV-------->+                          |
    +---->Wd-----+       |                          |
    |      +Ds**c+--Ss*s-+--------Os--------+       +--RW--+
    |      |     |       |                  |       |      |
LEFT-WALL the side.n affects.v [were] devastating.g . RIGHT-WALL



    +------------------------Xp-----------------------+
    +------------->WV------------->+                  |
    +-------->Wd---------+         |                  |
    |      +-----Dmc-----+         |                  |
    |      |     +---AN--+---Spx---+----Ost---+       +--RW--+
    |      |     |       |         |          |       |      |
LEFT-WALL the side.n effects.n were.v-d devastating.g . RIGHT-WALL
```
