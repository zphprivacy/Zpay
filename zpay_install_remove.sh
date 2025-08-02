#!/bin/bash
#Cookies zpyprivacy
# Zpay Installation Script with CLI Interface
# This script provides an interactive menu to install or uninstall Zpay

set -e  # Exit on any error

echo "🚀 Zpay Management Tool"

# Configuration
APP_NAME="Zpay"
INSTALL_DIR="$HOME/.local/share/zpay"
DESKTOP_FILE="$HOME/.local/share/applications/zpay.desktop"
DESKTOP_SHORTCUT="$HOME/Desktop/zpay.desktop"
BIN_DIR="$HOME/.local/bin"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${CYAN}${BOLD}$1${NC}"
}

# Function to show menu and get user choice
show_menu() {
    clear
    echo "╔════════════════════════════════════════╗"
    echo "║           Zpay Manager                 ║"
    echo "╚════════════════════════════════════════╝"
    echo
    print_header "What would you like to do?"
    echo
    echo "1) Install Zpay"
    echo "2) Uninstall Zpay"
    echo "3) Check Installation Status"
    echo "4) Show Help"
    echo "5) Exit"
    echo
    echo -n "Please select an option (1-5): "
}

# Function to get user input
get_user_choice() {
    local choice
    read -r choice
    echo "$choice"
}

# Function to pause and wait for user input
pause() {
    echo
    echo -n "Press Enter to continue..."
    read -r
}

# Function to check installation status
check_installation_status() {
    clear
    print_header "🔍 Checking Zpay Installation Status"
    echo
    
    local installed=false
    
    # Check installation directory
    if [ -d "$INSTALL_DIR" ]; then
        print_success "Installation directory found: $INSTALL_DIR"
        installed=true
    else
        print_warning "Installation directory not found"
    fi
    
    # Check AppImage
    if [ -f "$INSTALL_DIR/zpay.AppImage" ]; then
        print_success "AppImage found: $INSTALL_DIR/zpay.AppImage"
    else
        print_warning "AppImage not found"
    fi
    
    # Check desktop entry
    if [ -f "$DESKTOP_FILE" ]; then
        print_success "Desktop entry found: $DESKTOP_FILE"
    else
        print_warning "Desktop entry not found"
    fi
    
    # Check desktop shortcut
    if [ -f "$DESKTOP_SHORTCUT" ]; then
        print_success "Desktop shortcut found: $DESKTOP_SHORTCUT"
    else
        print_warning "Desktop shortcut not found"
    fi
    
    # Check command-line launcher
    if [ -f "$BIN_DIR/zpay" ]; then
        print_success "Command-line launcher found: $BIN_DIR/zpay"
    else
        print_warning "Command-line launcher not found"
    fi
    
    echo
    if [ "$installed" = true ]; then
        print_success "✅ Zpay appears to be installed"
    else
        print_warning "❌ Zpay does not appear to be installed"
    fi
}

# Function to confirm action
confirm_action() {
    local action="$1"
    echo
    echo -n "Are you sure you want to $action Zpay? (y/N): "
    local response
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Check if required files exist (for installation)
check_files() {
    print_status "Checking required files..."
    
    local missing_files=()
    
    if [ ! -f "*.AppImage" ] && [ ! -f "Zpay*.AppImage" ] && [ ! -f "zpay*.AppImage" ]; then
        # Try to find any AppImage file
        APPIMAGE_FILE=$(find . -name "*.AppImage" -type f | head -n 1)
        if [ -z "$APPIMAGE_FILE" ]; then
            missing_files+=("AppImage file")
        fi
    else
        APPIMAGE_FILE=$(find . -name "*[Zz]pay*.AppImage" -o -name "*.AppImage" | head -n 1)
    fi
    
    if [ ! -f "icon.png" ] && [ ! -f "*.png" ]; then
        ICON_FILE=$(find . -name "*.png" -type f | head -n 1)
        if [ -z "$ICON_FILE" ]; then
            missing_files+=("icon.png")
        fi
    else
        ICON_FILE=$(find . -name "icon.png" -o -name "*.png" | head -n 1)
    fi
    
    if [ ! -f ".env" ]; then
        print_warning ".env file not found (optional)"
    fi
    
    if [ ${#missing_files[@]} -gt 0 ]; then
        print_error "Missing required files: ${missing_files[*]}"
        echo "Please ensure you have the following files in the current directory:"
        echo "  - *.AppImage (your Zpay application)"
        echo "  - icon.png (application icon)"
        echo "  - .env (optional environment file)"
        return 1
    fi
    
    print_success "All required files found"
    print_status "AppImage: $APPIMAGE_FILE"
    print_status "Icon: $ICON_FILE"
    return 0
}

# Create directory structure
create_directories() {
    print_status "Creating directory structure..."
    
    # Create main installation directory
    mkdir -p "$INSTALL_DIR"
    
    # Create bin directory if it doesn't exist
    mkdir -p "$BIN_DIR"
    
    # Create applications directory
    mkdir -p "$(dirname "$DESKTOP_FILE")"
    
    print_success "Directories created"
}

# Install application files
install_files() {
    print_status "Installing application files..."
    
    # Copy AppImage
    cp "$APPIMAGE_FILE" "$INSTALL_DIR/zpay.AppImage"
    chmod +x "$INSTALL_DIR/zpay.AppImage"
    
    # Copy icon
    cp "$ICON_FILE" "$INSTALL_DIR/zpay.png"
    
    # Copy .env if it exists
    if [ -f ".env" ]; then
        cp ".env" "$INSTALL_DIR/.env"
        print_status "Environment file copied"
    fi
    
    print_success "Application files installed"
}

# Create desktop entry
create_desktop_entry() {
    print_status "Creating desktop entry..."
    
    cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Name=Zpay
Comment=Zpay Payment Receipt System
Exec=$INSTALL_DIR/zpay.AppImage
Icon=$INSTALL_DIR/zpay.png
Terminal=false
Type=Application
Categories=Office;Finance;
StartupNotify=true
StartupWMClass=Zpay
MimeType=application/x-zpay;
EOF

    # Make desktop file executable
    chmod +x "$DESKTOP_FILE"
    
    print_success "Desktop entry created"
}

# Create desktop shortcut
create_desktop_shortcut() {
    print_status "Creating desktop shortcut..."
    
    # Copy desktop file to desktop
    cp "$DESKTOP_FILE" "$DESKTOP_SHORTCUT"
    chmod +x "$DESKTOP_SHORTCUT"
    
    # For some desktop environments, mark as trusted
    if command -v gio &> /dev/null; then
        gio set "$DESKTOP_SHORTCUT" metadata::trusted true 2>/dev/null || true
    fi
    
    print_success "Desktop shortcut created"
}

# Create command-line launcher
create_launcher() {
    print_status "Creating command-line launcher..."
    
    cat > "$BIN_DIR/zpay" << EOF
#!/bin/bash
cd "$INSTALL_DIR"
exec "$INSTALL_DIR/zpay.AppImage" "\$@"
EOF

    chmod +x "$BIN_DIR/zpay"
    
    print_success "Command-line launcher created"
}

# Update desktop database
update_desktop_database() {
    print_status "Updating desktop database..."
    
    # Update desktop database
    if command -v update-desktop-database &> /dev/null; then
        update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true
    fi
    
    # Update icon cache
    if command -v gtk-update-icon-cache &> /dev/null; then
        gtk-update-icon-cache -f -t "$HOME/.local/share/icons/" 2>/dev/null || true
    fi
    
    # Update MIME database
    if command -v update-mime-database &> /dev/null; then
        update-mime-database "$HOME/.local/share/mime/" 2>/dev/null || true
    fi
    
    print_success "Desktop database updated"
}

# Add to PATH if needed
setup_path() {
    print_status "Setting up PATH..."
    
    # Check if ~/.local/bin is in PATH
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        print_warning "Added ~/.local/bin to PATH in ~/.bashrc"
        print_warning "Please run 'source ~/.bashrc' or restart your terminal"
    fi
    
    print_success "PATH setup complete"
}

# Installation function
install_zpay() {
    clear
    print_header "🚀 Installing Zpay"
    echo
    
    if ! confirm_action "install"; then
        print_warning "Installation cancelled"
        return
    fi
    
    if ! check_files; then
        pause
        return
    fi
    
    create_directories
    install_files
    create_desktop_entry
    create_desktop_shortcut
    create_launcher
    update_desktop_database
    setup_path
    
    echo
    echo "╔════════════════════════════════════════╗"
    echo "║         Installation Complete!         ║"
    echo "╚════════════════════════════════════════╝"
    echo
    print_success "Zpay has been successfully installed!"
    echo
    echo "📍 Installation location: $INSTALL_DIR"
    echo "🖥️  Desktop shortcut: Created"
    echo "📱 Application menu: Available"
    echo "💻 Command line: Type 'zpay' to run"
    echo
    echo "🔄 You may need to:"
    echo "   • Log out and log back in for full integration"
    echo "   • Run 'source ~/.bashrc' to update PATH"
    echo "   • Refresh your desktop/file manager"
    
    pause
}

# Uninstall function
uninstall_zpay() {
    clear
    print_header "🗑️  Uninstalling Zpay"
    echo
    
    if ! confirm_action "uninstall"; then
        print_warning "Uninstall cancelled"
        return
    fi
    
    print_status "Uninstalling Zpay..."
    
    local removed=false
    
    # Remove installation directory
    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
        print_success "Removed installation directory"
        removed=true
    fi
    
    # Remove desktop entry
    if [ -f "$DESKTOP_FILE" ]; then
        rm -f "$DESKTOP_FILE"
        print_success "Removed desktop entry"
        removed=true
    fi
    
    # Remove desktop shortcut
    if [ -f "$DESKTOP_SHORTCUT" ]; then
        rm -f "$DESKTOP_SHORTCUT"
        print_success "Removed desktop shortcut"
        removed=true
    fi
    
    # Remove launcher
    if [ -f "$BIN_DIR/zpay" ]; then
        rm -f "$BIN_DIR/zpay"
        print_success "Removed command-line launcher"
        removed=true
    fi
    
    # Update desktop database
    update_desktop_database
    
    if [ "$removed" = true ]; then
        print_success "✅ Zpay has been successfully uninstalled!"
    else
        print_warning "❌ No Zpay installation found to remove"
    fi
    
    pause
}

# Show help
show_help() {
    clear
    print_header "📖 Zpay Manager Help"
    echo
    echo "This script helps you manage Zpay installation on your system."
    echo
    echo "Available options:"
    echo "  1) Install Zpay    - Install Zpay with desktop integration"
    echo "  2) Uninstall Zpay  - Remove Zpay completely from your system"
    echo "  3) Check Status    - Check current installation status"
    echo "  4) Show Help       - Display this help information"
    echo "  5) Exit            - Exit the script"
    echo
    echo "Command line usage:"
    echo "  $0                 - Show interactive menu"
    echo "  $0 install         - Install directly"
    echo "  $0 uninstall       - Uninstall directly"
    echo "  $0 status          - Check status"
    echo "  $0 --help          - Show help"
    echo
    echo "Required files for installation:"
    echo "  • *.AppImage (Zpay application)"
    echo "  • icon.png (application icon)"
    echo "  • .env (optional environment file)"
    echo
    pause
}

# Main interactive loop
interactive_mode() {
    while true; do
        show_menu
        choice=$(get_user_choice)
        
        case $choice in
            1)
                install_zpay
                ;;
            2)
                uninstall_zpay
                ;;
            3)
                check_installation_status
                pause
                ;;
            4)
                show_help
                ;;
            5)
                clear
                print_success "👋 Thank you for using Zpay Manager!"
                exit 0
                ;;
            *)
                clear
                print_error "❌ Invalid option. Please select 1-5."
                sleep 1
                ;;
        esac
    done
}

# Handle command line arguments
case "${1:-}" in
    install)
        install_zpay
        ;;
    uninstall)
        uninstall_zpay
        ;;
    status)
        check_installation_status
        ;;
    --help|-h|help)
        show_help
        ;;
    "")
        interactive_mode
        ;;
    *)
        print_error "Unknown option: $1"
        echo "Use '$0 --help' for usage information"
        exit 1
        ;;
esac

#Cookies zpyprivacy
