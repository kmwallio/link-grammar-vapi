# Name our project
project('hello-link-grammar', ['vala', 'c'],
    version: '0.0.1'
)

# Get the package data directory under Meson
pkgdatadir = join_paths([ get_option('prefix'),
                          get_option('datadir'),
                          meson.project_name() ])

# Set this for convenience
conf = configuration_data()

conf.set_quoted('PKGDATADIR', pkgdatadir)
# Generate config.h
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf.set_quoted('RELEASE_NAME', meson.project_name())
conf.set_quoted('VERSION', meson.project_version())
add_global_arguments('-DDATADIR="' + get_option('datadir') + '"', language: 'c')
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

# Arguments for C
c_args = [
  '-include', 'config.h',
  '-w'
]

# Let's define our executable
add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')

# Find linkgrammar
linkgrammar = dependency('liblink-grammar', version: '>= 5.8.0', required: false)
if linkgrammar.found() == false
    cc = meson.get_compiler('c')
    linkgrammar = cc.find_library('liblink-grammar', required: true)
endif

# Let's define our executable
add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')

executable(
    meson.project_name(),
    'src/hello-link-grammar.vala',
    c_args: c_args,
     dependencies: [
        dependency('gobject-2.0'),
        dependency('gtk+-3.0'),
        linkgrammar
    ],
    vala_args: [
        meson.source_root() + '/vapi/config.vapi',
        meson.source_root() + '/vapi/linkgrammar.vapi'
    ],
    install : false
)