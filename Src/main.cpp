#include <SFML/Graphics.hpp>

#include "App/SFMLApp.h"

int main()
{
    SFMLApp* pGameApp = SFMLApp::Create();

    if(pGameApp->Init())
    {
        pGameApp->MainLoop();
    }

    SFMLApp::Destroy();

    return 0;
}
