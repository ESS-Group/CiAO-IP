$VAR1 = {
    'vname' => 'CiAO files',
    'depends' => '&ipstack',
    'dir' => './',
    'comp' => [
    {
        'subdir' => 'hw/hal',
        'files'=>'.(cc|h|ah)'
    },
    {
        'subdir' => 'util',
        'file'=>'types.h'
    }
    ]
};
